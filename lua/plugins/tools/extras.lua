-- Optional tools that cost nothing until used.

return {
	-- Database client (Postgres, MySQL, SQLite…): <Space>Db, then add a connection URL
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		keys = {
			{ "<leader>Db", "<cmd>DBUIToggle<cr>", desc = "Database UI (toggle)" },
			{ "<leader>Da", "<cmd>DBUIAddConnection<cr>", desc = "Add connection" },
			{ "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "Find query buffer" },
		},
		init = function()
			vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dadbod_ui"
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_auto_execute_table_helpers = 1
			vim.g.db_ui_win_position = "left"
			vim.g.db_ui_winwidth = 35
		end,
	},
	{
		"saghen/blink.cmp",
		opts = {
			sources = {
				per_filetype = { sql = { "snippets", "dadbod", "buffer" } },
				providers = { dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" } },
			},
		},
	},

	-- Markdown preview in the browser (README files)
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
		ft = "markdown",
		build = "cd app && npm install",
		keys = { { "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown preview", ft = "markdown" } },
		init = function() vim.g.mkdp_auto_close = 1 end,
	},

	{ "dstein64/vim-startuptime", cmd = "StartupTime", init = function() vim.g.startuptime_tries = 10 end },
}
