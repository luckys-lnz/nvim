-- buffline setup
--
return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "📌 Toggle Pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "🗑 Delete Non-Pinned Buffers" },
			{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "🚀 Close Other Buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "➡ Close Buffers to Right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "⬅ Close Buffers to Left" },
			{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "⏪ Previous Buffer" },
			{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "⏩ Next Buffer" },
			{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "⏪ Previous Buffer" },
			{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "⏩ Next Buffer" },
		},
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				always_show_bufferline = true,
				separator_style = "padded_slant",
				diagnostics_indicator = function(_, _, diag)
					local icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "📂 File Explorer",
						highlight = "Directory",
						text_align = "left",
						padding = 1,
					},
					{
						filetype = "padding", -- Fake filetype to add space
						text = " ",
						highlight = "Normal",
						padding = 1, -- Number of empty lines
					},
				},
				show_buffer_icons = true,
				show_close_icon = true,
				show_buffer_close_icons = true,
				hover = { enabled = true, delay = 200, reveal = { "close" } },
			},
			highlights = {
				fill = { bg = "#1e1e2e" },
				background = { fg = "#7f849c", bg = "#1e1e2e" },
				buffer_selected = { fg = "#ffffff", bg = "#45475a", bold = true, italic = false },
				separator_selected = { fg = "#89b4fa", bg = "#45475a" },
				separator_visible = { fg = "#3e4452", bg = "#1e1e2e" },
				separator = { fg = "#3e4452", bg = "#1e1e2e" },
				indicator_selected = { fg = "#f7768e", bg = "#45475a", bold = true },
				tab_selected = { fg = "#ffffff", bg = "#45475a", bold = true },
				tab_close = { fg = "#f7768e", bg = "#1e1e2e" },
			},
		},
	},
}
