-- Floating command line, nicer messages, LSP hover/signature docs.

return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			lsp = {
				progress = { enabled = true, view = "mini" },
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
				signature = { auto_open = { enabled = true, throttle = 50 } },
			},
			routes = {
				-- Quiet the chatter: "written", "N lines yanked", search counts…
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
							{ find = "%d+ lines? yanked" },
						},
					},
					view = "mini",
				},
				{ filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
				{ filter = { event = "notify", find = "No information available" }, opts = { skip = true } },
			},
			presets = {
				bottom_search = true, -- / and ? stay at the bottom like classic Vim
				command_palette = true, -- : opens a centred popup
				long_message_to_split = true,
				inc_rename = true, -- live rename preview (F2)
				lsp_doc_border = true,
			},
		},
		-- stylua: ignore
		keys = {
			{ "<leader>sN", function() require("noice").cmd("pick") end, desc = "Noice message history" },
			{ "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect cmdline output" },
			{ "<C-f>", function() if not require("noice.lsp").scroll(4) then return "<C-f>" end end, silent = true, expr = true, desc = "Scroll docs forward", mode = { "n", "s" } },
			{ "<C-b>", function() if not require("noice.lsp").scroll(-4) then return "<C-b>" end end, silent = true, expr = true, desc = "Scroll docs backward", mode = { "n", "s" } },
		},
		config = function(_, opts)
			-- Noice takes over the message area; clear stale messages from startup.
			if vim.o.filetype == "lazy" then vim.cmd([[messages clear]]) end
			require("noice").setup(opts)
		end,
	},
}
