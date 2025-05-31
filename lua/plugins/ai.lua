return {
	-- Copilot for AI completions
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = true,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom", -- | top | left | right
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						accept = "<M-l>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 18.x
				server_opts_overrides = {},
			})
		end,
	},

	-- Neural code completion (alternative to Copilot)
	{
		"codota/tabnine-nvim",
		enabled = false, -- Disable if using Copilot
		build = "./dl_binaries.sh",
		config = function()
			require("tabnine").setup({
				disable_auto_comment = true,
				accept_keymap = "<Tab>",
				dismiss_keymap = "<C-]>",
				debounce_ms = 800,
				suggestion_color = { gui = "#808080", cterm = 244 },
				exclude_filetypes = { "TelescopePrompt", "NvimTree" },
				log_file_path = nil, -- absolute path to Tabnine log file
			})
		end,
	},

	-- AI commit messages
	{
		"huynle/ogpt.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("ogpt").setup({
				api_key_cmd = "echo $OPENAI_API_KEY",
				default_provider = "openai",
				providers = {
					openai = {
						model = "gpt-3.5-turbo",
						temperature = 0.1,
					},
				},
			})
		end,
		keys = {
			{
				"<leader>gc",
				function()
					require("ogpt").commit_message()
				end,
				desc = "Generate commit message",
			},
		},
	},

	-- Cursor-like keymaps setup
	{
		"folke/which-key.nvim",
		optional = true,
		opts = {
			defaults = {
				["<leader>a"] = { name = "+ai" },
			},
		},
	},
}
