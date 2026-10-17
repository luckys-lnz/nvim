-- Moving and editing faster than with a mouse.

return {
	-- Jump anywhere on screen: press s, type 2 chars, press the label.
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = { modes = { search = { enabled = false } } },
		-- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
			{ "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Flash select syntax node" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote flash" },
			{ "<C-s>", mode = "c", function() require("flash").toggle() end, desc = "Toggle flash in / search" },
		},
	},

	-- Surround: ys{motion}{char} add · ds{char} delete · cs{old}{new} change
	-- (v4 registers its own default keymaps when it loads; visual mode: S)
	{ "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} },

	-- Multiple cursors (VS Code: Ctrl+D, Ctrl+Shift+L, Ctrl+Alt+↑/↓)
	{
		"mg979/vim-visual-multi",
		branch = "master",
		keys = {
			{ "<M-n>", mode = { "n", "x" }, desc = "Multi-cursor: add next match" },
			{ "<M-a>", mode = { "n", "x" }, desc = "Multi-cursor: select all matches" },
			{ "<C-M-j>", desc = "Multi-cursor: add cursor below" },
			{ "<C-M-k>", desc = "Multi-cursor: add cursor above" },
		},
		init = function()
			vim.g.VM_default_mappings = 0
			vim.g.VM_maps = {
				["Find Under"] = "<M-n>",
				["Find Subword Under"] = "<M-n>",
				["Select All"] = "<M-a>",
				["Visual All"] = "<M-a>",
				["Add Cursor Down"] = "<C-M-j>",
				["Add Cursor Up"] = "<C-M-k>",
				["Skip Region"] = "<M-x>", -- inside VM: skip this match
				["Remove Region"] = "<M-p>", -- inside VM: drop this cursor
			}
			vim.g.VM_highlight_matches = "underline"
			vim.g.VM_theme = "auto"
		end,
	},

	-- Better comments in JSX/TSX (and other embedded languages) for gc / Ctrl+/
	{ "folke/ts-comments.nvim", event = "VeryLazy", opts = {} },

	-- Highlight and jump between TODO / FIX / HACK / NOTE comments
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TodoTrouble" },
		opts = {},
		-- stylua: ignore
		keys = {
			{ "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO comment" },
			{ "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO comment" },
			{ "<leader>st", function() Snacks.picker.todo_comments() end, desc = "TODOs" },
			{ "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "TODO/FIX/FIXME" },
			{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "TODOs (Trouble)" },
		},
	},
}
