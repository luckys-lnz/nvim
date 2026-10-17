-- which-key: press <Space> (or g, z, ], [ …) and wait — every key is listed.
-- This is your #1 tool for learning the layout.  <Space>? opens the full guide.

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			delay = function(ctx) return ctx.plugin and 0 or 300 end,
			win = { border = "rounded" },
			spec = {
				{
					mode = { "n", "x" },
					{ "<leader>a", group = "ai (copilot)", icon = { icon = "\u{f4b8} ", color = "purple" } },
					{ "<leader>b", group = "buffer (tabs)" },
					{ "<leader>c", group = "code" },
					{ "<leader>d", group = "debug" },
					{ "<leader>D", group = "database" },
					{ "<leader>f", group = "find" },
					{ "<leader>g", group = "git" },
					{ "<leader>h", group = "git hunks" },
					{ "<leader>q", group = "quit / session" },
					{ "<leader>r", group = "run" },
					{ "<leader>s", group = "search" },
					{ "<leader>t", group = "test" },
					{ "<leader>u", group = "ui toggles" },
					{ "<leader>w", group = "window" },
					{ "<leader>x", group = "diagnostics / lists" },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "g", group = "goto" },
					{ "gr", group = "lsp (rename/refs/actions)" },
					{ "gp", group = "peek" },
					{ "z", group = "fold / scroll" },
					{ "gx", desc = "Open link under cursor" },
				},
			},
		},
		keys = {
			{
				"<leader>K",
				function() require("which-key").show({ global = false }) end,
				desc = "Keymaps for this buffer",
			},
		},
	},
}
