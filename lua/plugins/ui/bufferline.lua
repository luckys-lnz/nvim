-- Buffer "tabs" across the top, like VS Code's editor tabs.

local keys = {
	{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
	{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
	{ "<A-S-h>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
	{ "<A-S-l>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
	{ "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin buffer" },
	{ "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Close unpinned buffers" },
	{ "<leader>bb", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
	{ "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close buffers to the left" },
	{ "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Close buffers to the right" },
}
-- Alt+1..9 jumps to the Nth tab (VS Code: Ctrl+1..9 / Alt+1..9)
for i = 1, 9 do
	keys[#keys + 1] = { "<A-" .. i .. ">", "<cmd>BufferLineGoToBuffer " .. i .. "<cr>", desc = "Go to buffer " .. i }
end

return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = keys,
		opts = {
			options = {
				close_command = function(n) Snacks.bufdelete(n) end,
				right_mouse_command = function(n) Snacks.bufdelete(n) end,
				indicator = { icon = "▎", style = "icon" },
				buffer_close_icon = "\u{f00d}",
				modified_icon = "\u{25cf}",
				left_trunc_marker = "\u{f053}",
				right_trunc_marker = "\u{f054}",
				max_name_length = 18,
				tab_size = 18,
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(_, _, diag)
					local icons = require("config.icons").diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Explorer",
						highlight = "Directory",
						text_align = "left",
						separator = true,
					},
				},
				show_close_icon = false,
				separator_style = "thin",
				always_show_bufferline = true,
				hover = { enabled = true, delay = 150, reveal = { "close" } },
				sort_by = "insert_after_current",
			},
		},
		config = function(_, opts)
			opts.highlights = require("catppuccin.special.bufferline").get_theme()
			require("bufferline").setup(opts)
			-- Restore buffer list after a session load
			vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
				callback = function()
					---@diagnostic disable-next-line: undefined-global -- global defined by bufferline
					vim.schedule(function() pcall(nvim_bufferline) end)
				end,
			})
		end,
	},
}
