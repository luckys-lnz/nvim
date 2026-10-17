-- File explorer sidebar (VS Code: Ctrl+Shift+E / Ctrl+B).  Press ? inside it for help.

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer (toggle)" },
			{ "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Explorer (toggle)" },
			{ "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Explorer: reveal current file" },
			{ "<leader>ge", "<cmd>Neotree float git_status<cr>", desc = "Git status explorer" },
		},
		deactivate = function() vim.cmd([[Neotree close]]) end,
		init = function()
			-- `nvim .` opens the explorer instead of netrw
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("neotree_start_directory", { clear = true }),
				desc = "Start Neo-tree with directory",
				once = true,
				callback = function()
					if package.loaded["neo-tree"] then return end
					local stats = vim.uv.fs_stat(vim.fn.argv(0))
					if stats and stats.type == "directory" then require("neo-tree") end
				end,
			})
		end,
		opts = function()
			local icons = require("config.icons").ui
			-- Renaming/moving a file updates imports through the LSP (like VS Code)
			local function on_move(data) Snacks.rename.on_rename_file(data.source, data.destination) end
			local events = require("neo-tree.events")
			return {
				sources = { "filesystem", "buffers", "git_status" },
				open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "edgy" },
				event_handlers = {
					{ event = events.FILE_MOVED, handler = on_move },
					{ event = events.FILE_RENAMED, handler = on_move },
				},
				default_component_configs = {
					indent = {
						with_markers = true,
						with_expanders = true,
						expander_collapsed = icons.chevron_right,
						expander_expanded = icons.chevron_down,
					},
					icon = {
						folder_closed = icons.folder,
						folder_open = icons.folder_open,
						folder_empty = icons.folder_empty,
						default = icons.file,
					},
					modified = { symbol = icons.modified },
					git_status = { align = "right" },
				},
				window = {
					position = "left",
					width = 32,
					mappings = {
						["<space>"] = "none", -- leave <Space> to the leader key
						["l"] = "open",
						["h"] = "close_node",
						["<Tab>"] = { "toggle_preview", config = { use_float = true } },
						["Y"] = {
							function(state)
								local path = state.tree:get_node():get_id()
								vim.fn.setreg("+", path, "c")
								vim.notify("Copied: " .. path)
							end,
							desc = "Copy path to clipboard",
						},
						["O"] = {
							function(state) vim.ui.open(state.tree:get_node().path) end,
							desc = "Open with system app",
						},
					},
				},
				filesystem = {
					bind_to_cwd = false,
					follow_current_file = { enabled = true },
					use_libuv_file_watcher = true,
					filtered_items = {
						hide_dotfiles = false,
						hide_gitignored = true,
						hide_by_name = { ".DS_Store", "thumbs.db" },
						never_show = { ".git" },
					},
				},
			}
		end,
		config = function(_, opts)
			require("neo-tree").setup(opts)
			-- Refresh git status after leaving lazygit
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
