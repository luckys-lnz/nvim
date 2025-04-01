-- lua/config/lazy.lua
-- Lazy.nvim bootstrap and configuration

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	-- Bootstrap lazy.nvim
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
	spec = {
		-- Import plugins
		{ import = "plugins" },

		-- WakaTime for coding activity tracking
		{ "wakatime/vim-wakatime", lazy = false },

		-- Copilot integration with nvim-cmp
		{
			"zbirenbaum/copilot-cmp",
			event = "InsertEnter",
			dependencies = { "zbirenbaum/copilot.lua", "hrsh7th/nvim-cmp" },
			config = function()
				require("copilot_cmp").setup()
			end,
		},
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			config = function()
				require("copilot").setup({
					suggestion = { enabled = false },
					panel = { enabled = false },
				})
			end,
		},
	},

	defaults = {
		lazy = true,
		version = "*", -- To Always use the latest stable version
	},

	install = { colorscheme = { "catppuccin" } },

	checker = {
		enabled = true, -- Automatically check for plugin updates
		notify = true, -- Get notifications when updates are available
	},

	performance = {
		rtp = {
			disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
		},
	},

	ui = {
		border = "rounded",
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🔑",
			plugin = "🔌",
			runtime = "💻",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
