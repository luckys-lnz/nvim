-- lua/plugins/ui.lua
-- UI enhancements for a VS Code-like experience
return {
	-- VS Code-like icons
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},

	--  input UI
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
		opts = {
			input = {
				enabled = true,
				default_prompt = "Input:",
				prompt_align = "left",
				insert_only = true,
				border = "rounded",
				relative = "cursor",
				prefer_width = 40,
				width = nil,
				max_width = { 140, 0.9 },
				min_width = { 20, 0.2 },
				win_options = {
					winblend = 0,
					winhighlight = "Normal:Normal,NormalNC:Normal,FloatBorder:FloatBorder",
				},
				mappings = {
					n = {
						["<Esc>"] = "Close",
						["<CR>"] = "Confirm",
					},
					i = {
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
						["<Up>"] = "HistoryPrev",
						["<Down>"] = "HistoryNext",
					},
				},
			},
			select = {
				enabled = true,
				backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
				trim_prompt = true,
				telescope = nil,
				fzf = {
					window = {
						width = 0.5,
						height = 0.4,
					},
				},
				nui = {
					position = "50%",
					size = nil,
					relative = "editor",
					border = {
						style = "rounded",
					},
					buf_options = {
						swapfile = false,
						filetype = "DressingSelect",
					},
					win_options = {
						winblend = 0,
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					},
					max_width = 80,
					max_height = 40,
					min_width = 40,
					min_height = 10,
				},
				builtin = {
					border = "rounded",
					relative = "editor",
					win_options = {
						winblend = 0,
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					},
					width = nil,
					max_width = { 140, 0.8 },
					min_width = { 40, 0.2 },
					height = nil,
					max_height = 0.9,
					min_height = { 10, 0.2 },
					mappings = {
						["<Esc>"] = "Close",
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
					},
				},
			},
		},
	},

	--  indentation guides
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		main = "ibl",
	},

	-- active indent guide and indent text objects
	{
		"echasnovski/mini.indentscope",
		version = "*", -- wait till new 0.7.0 release to put it back on semver
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	--  scrollbar
	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		config = function()
			require("scrollbar").setup({
				handle = {
					color = "#3e4452",
				},
				marks = {
					Search = { color = "#ff9e64" },
					Error = { color = "#db4b4b" },
					Warn = { color = "#e0af68" },
					Info = { color = "#0db9d7" },
					Hint = { color = "#1abc9c" },
					Misc = { color = "#9d7cd8" },
				},
				handlers = {
					cursor = true,
					diagnostic = true,
					gitsigns = true,
					handle = true,
					search = true,
				},
			})
		end,
	},

	-- smooth scrolling
	{
		"karb94/neoscroll.nvim",
		event = "BufReadPost",
		config = function()
			require("neoscroll").setup({
				mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
				hide_cursor = true,
				stop_eof = true,
				respect_scrolloff = false,
				cursor_scrolls_alone = true,
				easing_function = "sine",
				pre_hook = nil,
				post_hook = nil,
			})
		end,
	},

	--  keybinding help
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["gz"] = { name = "+surround" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+code" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>h"] = { name = "+hunks" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				["<leader>u"] = { name = "+ui" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			},
			window = {
				border = "rounded",
				padding = { 2, 2, 2, 2 },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			opts.defaults = opts.defaults or {}
			wk.setup(opts)

			-- Set transparent background for which-key
			vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "NONE" })
		end,
	},
}
