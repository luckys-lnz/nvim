return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		keys = {
			{ "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer (VS Code)" },
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer toggle" },
			{ "<leader>E", "<cmd>Neotree refresh<cr>", desc = "Reveal Explorer Refresh" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
			if vim.fn.argc() == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		opts = {
			sources = { "filesystem", "buffers", "git_status", "document_symbols" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = {
				mappings = {
					["<space>"] = "none",
					["a"] = "add", -- Create
					["d"] = "delete", -- Delete
					["r"] = "rename", -- Rename
					["R"] = "refresh", -- Refresh
					["x"] = "cut_to_clipboard", -- Cut
					["c"] = "copy_to_clipboard", -- Copy
					["p"] = "paste_from_clipboard", -- Paste
					["y"] = "copy_filename", -- Copy name
					["Y"] = "copy_path", -- Copy relative path
					["<CR>"] = "open", -- Open
					["<Tab>"] = "open_preview", -- Preview
					[">"] = "next_sibling", -- Next sibling
					["<"] = "prev_sibling", -- Previous sibling
					["K"] = "navigate_up", -- Parent directory
					["h"] = "close_node", -- Close directory
					["l"] = "open", -- Open (same as Enter)
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					default = "",
				},
				git_status = {
					symbols = {
						added = "", -- Plus sign for added files
						modified = "", -- Small dot for modifications
						deleted = "✖", -- Cross for deleted files
						renamed = "󰁕", -- Arrow for renamed files
						untracked = "", -- Question mark for untracked files
						ignored = "", -- Eye-off for ignored files
						unstaged = "󰄱", -- Warning for unstaged changes
						staged = "", -- Checkmark for staged changes
						conflict = "", -- Git merge icon for conflicts
					},
				},
			},
		},
		config = function(_, opts)
			require("neo-tree").setup(opts)
			vim.api.nvim_create_autocmd("TermClose", {
				pattern = "*lazygit",
				callback = function()
					if package.loaded["neo-tree.sources.git_status"] then
						require("neo-tree.sources.git_status").refresh()
					end
				end,
			})
		end,
	},
}
