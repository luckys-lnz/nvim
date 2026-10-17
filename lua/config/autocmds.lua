-- Autocommands.  :autocmd <group> lists what is registered.

local function augroup(name) return vim.api.nvim_create_augroup("user_" .. name, { clear = true }) end
local autocmd = vim.api.nvim_create_autocmd

-- Flash the yanked text
autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function() vim.hl.on_yank({ timeout = 180 }) end,
})

-- Reload files changed outside Neovim (git checkout, formatter, etc.)
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then vim.cmd.checktime() end
	end,
})

-- Keep splits balanced when the terminal is resized
autocmd("VimResized", {
	group = augroup("resize_splits"),
	callback = function()
		local tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. tab)
	end,
})

-- Reopen files at the last cursor position
autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(ev)
		local exclude = { gitcommit = true, gitrebase = true }
		if exclude[vim.bo[ev.buf].filetype] or vim.b[ev.buf].last_loc_done then return end
		vim.b[ev.buf].last_loc_done = true
		local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
		if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Close helper windows with `q`
autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"checkhealth",
		"dap-float",
		"dap-repl",
		"gitsigns-blame",
		"help",
		"lspinfo",
		"man",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"startuptime",
	},
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, ev.buf, { force = true })
			end, { buffer = ev.buf, silent = true, desc = "Close window" })
		end)
	end,
})

-- Prose: wrap + spell
autocmd("FileType", {
	group = augroup("prose"),
	pattern = { "gitcommit", "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Language indentation defaults (an .editorconfig in the project wins)
autocmd("FileType", {
	group = augroup("indent"),
	pattern = { "c", "cpp", "python" },
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
	end,
})

-- Create missing parent directories on save
autocmd("BufWritePre", {
	group = augroup("auto_create_dir"),
	callback = function(ev)
		if ev.match:match("^%w%w+:[\\/][\\/]") then return end
		local file = vim.uv.fs_realpath(ev.match) or ev.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
