-- Config self-test.  Run from anywhere:
--   nvim --headless -c "luafile ~/.config/nvim/scripts/check.lua"
--   nvim --headless -c "luafile ~/.config/nvim/scripts/check.lua" path/to/file.py   (also checks LSP/treesitter)
--
-- Exits non-zero if anything is wrong, so it can run in CI or a git hook.

local failures, notes = {}, {}
local function fail(msg) failures[#failures + 1] = msg end
local function note(msg) notes[#notes + 1] = msg end

local function finish()
	for _, n in ipairs(notes) do
		io.stdout:write("  · " .. n .. "\n")
	end
	if #failures == 0 then
		io.stdout:write("✔ all checks passed\n")
		vim.cmd("qa!")
	else
		for _, f in ipairs(failures) do
			io.stdout:write("✘ " .. f .. "\n")
		end
		vim.cmd("cq!")
	end
end

-- Let VeryLazy plugins and their keymaps register first.
vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })

vim.defer_fn(function()
	-- 1. Every global key in the Guru cheatsheet must be an exact mapping.
	--    (maparg, not mapcheck: which-key's prefix triggers would match anything.)
	local guru = require("guru.keys").list
	local function mapped(e) return vim.fn.maparg(e.keys, e.mode or "n") ~= "" end
	local function disabled(e)
		local p = e.plugin and require("lazy.core.config").spec.disabled[e.plugin]
		if p then note(("skipped %s: %s is disabled on this machine"):format(e.keys, e.plugin)) end
		return p
	end
	for _, e in ipairs(guru) do
		if not e.kind and not e.keys:find(" ") and not mapped(e) then
			fail(("cheatsheet key not mapped: %s (%s) — %s"):format(e.keys, e.mode or "n", e.desc))
		end
	end

	-- 2. Plugins that can never load (lazy, but no trigger and nothing depends on them).
	local Config = require("lazy.core.config")
	local depended = {}
	for _, p in pairs(Config.plugins) do
		for _, d in ipairs(p.dependencies or {}) do
			depended[d] = true
		end
	end
	for name, p in pairs(Config.plugins) do
		local h = p._.handlers or {}
		if
			p.lazy
			and not p._.loaded
			and not depended[name]
			and not (h.event or h.cmd or h.keys or h.ft)
			and not p.module
		then
			note("plugin only loads via require(): " .. name)
		end
	end

	-- 3. Errors recorded during startup (:messages, and notifications noice/snacks captured).
	local msgs = vim.api.nvim_exec2("messages", { output = true }).output
	for line in msgs:gmatch("[^\n]+") do
		if line:match("^E%d+:") or line:match("[Ee]rror") then fail("startup message: " .. line) end
	end
	local function notify_errors()
		for _, n in ipairs(Snacks.notifier.get_history()) do
			if n.level == "error" then fail("notification: " .. tostring(n.msg):gsub("\n.*", "")) end
		end
	end

	-- 4. Optional: language checks for the file passed on the command line.
	local buf = vim.api.nvim_get_current_buf()
	local file = vim.api.nvim_buf_get_name(buf)
	if file == "" then
		notify_errors()
		return finish()
	end

	local ft = vim.bo[buf].filetype
	if not vim.treesitter.highlighter.active[buf] then fail("treesitter highlighting not active for " .. ft) end
	local ok, conform = pcall(require, "conform")
	if ok then
		local names = vim.tbl_map(function(f) return f.name end, conform.list_formatters_to_run(buf))
		note(("formatters for %s: %s"):format(ft, #names > 0 and table.concat(names, ", ") or "(lsp fallback)"))
	end

	local expected = vim.split(vim.env.EXPECT_LSP or "", ",", { trimempty = true })
	local deadline = vim.uv.now() + 20000
	local function poll()
		local names = vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients({ bufnr = buf }))
		local missing = vim.tbl_filter(function(n) return not vim.list_contains(names, n) end, expected)
		if #missing == 0 or vim.uv.now() > deadline then
			note("LSP attached: " .. (#names > 0 and table.concat(names, ", ") or "none"))
			for _, n in ipairs(missing) do
				fail("LSP did not attach: " .. n)
			end
			-- buffer-local keymaps: LSP ones, filetype ones, and git ones (if the file is tracked)
			local git = vim.b[buf].gitsigns_head ~= nil
			for _, e in ipairs(guru) do
				local wanted = (e.kind == "lsp" and #names > 0 and (not e.ft or e.ft == ft))
					or (e.kind == "buffer" and git)
				if wanted and not e.keys:find(" ") and not disabled(e) and not mapped(e) then
					fail(("buffer key not mapped in %s: %s — %s"):format(ft, e.keys, e.desc))
				end
			end
			note("git-tracked: " .. tostring(git))
			-- insert-mode <C-k> must be signature help (not stolen by completion)
			local ck = vim.fn.maparg("<C-k>", "i", false, true)
			if #names > 0 and ck.desc ~= "Signature help" then fail("<C-k> (insert) is not signature help") end
			notify_errors()
			return finish()
		end
		vim.defer_fn(poll, 250)
	end
	poll()
end, 500)
