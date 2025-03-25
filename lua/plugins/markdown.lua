return {
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" }, -- Load only for Markdown files
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
		keys = {
			{
				"<leader>mp",
				function()
					vim.cmd("MarkdownPreviewToggle")
				end,
				desc = "Toggle Markdown Preview",
			},
		},
		init = function()
			-- Configure markdown preview settings if needed
			vim.g.mkdp_auto_start = 0 -- Don't auto-start preview
			vim.g.mkdp_auto_close = 1 -- Auto-close preview when buffer is closed
			vim.g.mkdp_refresh_slow = 0 -- Ensure fast refresh
			vim.g.mkdp_browser = "" -- Use system default browser
		end,
	},
}
