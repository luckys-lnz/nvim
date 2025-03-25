return {
	-- VS Code-like terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{ "<C-`>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
			{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
			{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal Float" },
			{ "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal Horizontal" },
			{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal Vertical" },
		},
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<C-`>]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = false, -- Disable shading for transparency
			shading_factor = 0,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "FloatBorder",
					background = "Normal",
				},
			},
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
			-- Set transparent background for toggleterm
			vim.api.nvim_set_hl(0, "ToggleTerm", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "ToggleTermBorder", { bg = "NONE" })
		end,
	},
}
