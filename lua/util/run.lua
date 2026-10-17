-- "Run this file" and "run an npm script", shown in a terminal split.

local M = {}

---@type table<string, fun(file: string): string>
local runners = {
	python = function(f) return "python3 " .. vim.fn.shellescape(f) end,
	javascript = function(f) return "node " .. vim.fn.shellescape(f) end,
	-- Node 22.6+ strips TypeScript types natively; npx tsx covers older setups.
	typescript = function(f) return "npx --yes tsx " .. vim.fn.shellescape(f) end,
	c = function(f)
		local out = vim.fn.tempname()
		return ("cc -Wall -Wextra -g %s -o %s && %s"):format(vim.fn.shellescape(f), out, out)
	end,
	lua = function(f) return "nvim -l " .. vim.fn.shellescape(f) end,
	sh = function(f) return "bash " .. vim.fn.shellescape(f) end,
}

local function run(cmd, cwd)
	Snacks.terminal(cmd, { cwd = cwd, auto_close = false, win = { position = "bottom", height = 0.35 } })
end

function M.file()
	local ft, file = vim.bo.filetype, vim.api.nvim_buf_get_name(0)
	local runner = runners[ft]
	if not runner or file == "" then
		return vim.notify("No runner for filetype '" .. ft .. "'", vim.log.levels.WARN, { title = "Run" })
	end
	vim.cmd("silent! write")
	run(runner(file), vim.fn.fnamemodify(file, ":h"))
end

function M.npm_script()
	local pkg = vim.fs.find("package.json", { upward = true, path = vim.fn.expand("%:p:h") })[1]
	if not pkg then return vim.notify("No package.json found", vim.log.levels.WARN, { title = "Run" }) end
	local ok, json = pcall(vim.json.decode, table.concat(vim.fn.readfile(pkg), "\n"))
	local scripts = ok and json.scripts or {}
	local names = vim.tbl_keys(scripts)
	table.sort(names)
	if #names == 0 then return vim.notify("package.json has no scripts", vim.log.levels.WARN) end
	local root = vim.fs.dirname(pkg)
	local pm = vim.uv.fs_stat(root .. "/pnpm-lock.yaml") and "pnpm"
		or vim.uv.fs_stat(root .. "/yarn.lock") and "yarn"
		or vim.uv.fs_stat(root .. "/bun.lockb") and "bun"
		or "npm"
	vim.ui.select(names, {
		prompt = pm .. " run",
		format_item = function(name) return ("%-12s %s"):format(name, scripts[name]) end,
	}, function(choice)
		if choice then run(pm .. " run " .. choice, root) end
	end)
end

return M
