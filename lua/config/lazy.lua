-- Plugin manager bootstrap.  :Lazy opens the UI, :Lazy sync updates everything.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n" .. out, "ErrorMsg" } }, true, {})
		return
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Every folder must be imported explicitly; lazy does not recurse.
	spec = {
		{ import = "plugins.ui" },
		{ import = "plugins.editor" },
		{ import = "plugins.coding" },
		{ import = "plugins.lang" },
		{ import = "plugins.tools" },
	},
	defaults = {
		-- Plugins load at startup unless the spec gives a trigger (event/cmd/keys/ft).
		lazy = false,
		-- Track HEAD; reproducibility comes from lazy-lock.json (commit it!).
		version = false,
	},
	install = { colorscheme = { "catppuccin", "habamax" } },
	checker = { enabled = true, notify = false }, -- updates show as a badge in :Lazy
	change_detection = { notify = false },
	rocks = { enabled = false },
	ui = { border = "rounded", backdrop = 100 },
	performance = {
		rtp = {
			disabled_plugins = { "gzip", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
		},
	},
})
