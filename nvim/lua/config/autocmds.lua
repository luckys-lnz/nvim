-- lua/config/autocmds.lua
-- Auto commands

local function augroup(name)
	return vim.api.nvim_create_augroup("vscode_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"lspinfo",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Auto create dir when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Auto format on save (if formatter available)
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("auto_format"),
	callback = function()
		vim.lsp.buf.format({ timeout_ms = 1000 })
	end,
})

-- -- Auto close NeoTree when it's the last window
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	group = augroup("neotree_auto_close"),
-- 	callback = function()
-- 		local layout = vim.api.nvim_call_function("winlayout", {})
-- 		if layout[1] == "leaf" and vim.bo.filetype == "neo-tree" and layout[2][1] == vim.api.nvim_get_current_win() then
-- 			vim.cmd("quit")
-- 		end
-- 	end,
-- })

-- Auto close NeoTree when it's the last window
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("neotree_auto_close"),
	callback = function()
		-- Get current window layout
		local layout = vim.fn.winlayout()

		-- Ensure we have a valid layout and only one open window
		if layout[1] == "leaf" and vim.bo.filetype == "neo-tree" then
			-- Prevent quitting Neovim completely
			if #vim.api.nvim_list_wins() > 1 then
				vim.cmd("quit")
			end
		end
	end,
})

-- Add autocmd to ensure transparent backgrounds are applied consistently
-- Ensure transparent backgrounds
vim.api.nvim_create_autocmd("ColorScheme", {
	group = augroup("transparent_bg"),
	callback = function()
		-- Set transparent backgrounds for various UI elements
		local transparent_bg_groups = {
			"Normal",
			"NormalNC",
			"NormalFloat",
			"FloatBorder",
			"WhichKeyFloat",
			"NormalSB",
			"SignColumn",
			"LineNr",
			"EndOfBuffer",
			"CursorLineNr",
			"TelescopeNormal",
			"TelescopeBorder",
			"NotifyBackground",
			"StatusLine",
			"StatusLineNC",
		}

		for _, group in ipairs(transparent_bg_groups) do
			vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
		end
	end,
})
