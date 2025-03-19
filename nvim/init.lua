-- init.lua
-- Entry point for Neovim configuration

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Basic Neovim settings
require("config.options")
-- Keymaps
require("config.keymaps")
-- Autocommands
require("config.autocmds")

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- Import all plugin modules
		{ import = "plugins" },
	},
	defaults = {
		lazy = true, -- Load plugins on demand for better startup time
		version = false, -- Always use the latest git commit
	},
	install = { colorscheme = { "catppuccin" } }, --- another option for colorscheme "habamax"
	checker = { enabled = true }, -- Automatically check for plugin updates
	performance = {
		rtp = {
			-- Disable some built-in plugins we don't need
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	ui = {
		border = "rounded", -- Display borders in the UI
		winblend = 0, -- Make UI fully opaque for transparency
	},
})

-- Ensure transparency is applied after colorscheme is loaded
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- Apply transparent background
		vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", ctermbg = "NONE" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" })
		vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE", ctermbg = "NONE" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", ctermbg = "NONE" })
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", ctermbg = "NONE" })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", ctermbg = "NONE" })
	end,
})
