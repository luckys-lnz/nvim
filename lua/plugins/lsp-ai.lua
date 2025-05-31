return {
	-- Enhanced LSP with AI features
	{
		"jinzhongjia/LspUI.nvim",
		branch = "main",
		config = function()
			require("LspUI").setup({
				-- config options
				lightbulb = {
					enable = true,
					command_enable = true,
					text = "💡",
					debounce = 10,
					sign_priority = 40,
					virtual_text = true,
				},
				code_action = {
					enable = true,
					command_enable = true,
					icon = "💡",
					keybind = {
						exec = "<CR>",
						prev = "k",
						next = "j",
						quit = "q",
					},
				},
				hover = {
					enable = true,
					command_enable = true,
					keybind = {
						prev = "p",
						next = "n",
						quit = "q",
					},
				},
				rename = {
					enable = true,
					command_enable = true,
					auto_select = true,
					keybind = {
						change = "<CR>",
						quit = "<ESC>",
					},
				},
				diagnostic = {
					enable = true,
					command_enable = true,
					icons = {
						error = "🚨",
						warn = "⚠️",
						info = "ℹ️",
						hint = "💡",
					},
				},
				definition = {
					enable = true,
					command_enable = true,
					keybind = {
						edit = "<C-o>",
						vsplit = "<C-v>",
						split = "<C-x>",
						tabe = "<C-t>",
						quit = "q",
					},
				},
			})
		end,
	},
}
