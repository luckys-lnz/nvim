return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false, -- telescope did only one release, so use HEAD for now
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find in Files (Grep)" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
			{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
			{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
			{ "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
			{ "<leader>ft", "<cmd>Telescope treesitter<cr>", desc = "Treesitter" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				enabled = vim.fn.executable("make") == 1,
			},
		},
		opts = {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				mappings = {
					i = {
						["<C-j>"] = function(...)
							return require("telescope.actions").move_selection_next(...)
						end,
						["<C-k>"] = function(...)
							return require("telescope.actions").move_selection_previous(...)
						end,
						["<C-n>"] = function(...)
							return require("telescope.actions").cycle_history_next(...)
						end,
						["<C-p>"] = function(...)
							return require("telescope.actions").cycle_history_prev(...)
						end,
						["<C-c>"] = function(...)
							return require("telescope.actions").close(...)
						end,
						["<C-u>"] = function(...)
							return require("telescope.actions").preview_scrolling_up(...)
						end,
						["<C-d>"] = function(...)
							return require("telescope.actions").preview_scrolling_down(...)
						end,
					},
					n = {
						["q"] = function(...)
							return require("telescope.actions").close(...)
						end,
					},
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
				path_display = { "truncate" },
				winblend = 0,
				border = true,
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,
				set_env = { ["COLORTERM"] = "truecolor" },
				layout_config = {
					horizontal = {
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")

			-- Set transparent background for telescope
			vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE" })
		end,
	},
}
