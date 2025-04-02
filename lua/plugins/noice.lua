return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			-- Customize command line experience
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
				opts = {
					position = {
						row = "10%", -- Centered closer to the top of the screen
						col = "50%",
					},
					size = {
						width = "30%", -- Adjust width for better visibility
						height = "auto",
					},
				},
				icons = {
					["/"] = { icon = "🔍", hl_group = "DiagnosticWarn" },
					["?"] = { icon = "❓", hl_group = "DiagnosticWarn" },
					[":"] = { icon = "⚙️", hl_group = "DiagnosticInfo" },
				},
			},

			-- Enhanced messages and notifications
			messages = {
				enabled = true,
				view = "notify",
				view_error = "notify",
				view_warn = "notify",
				view_history = "messages",
				view_search = "virtualtext",
			},

			-- Better LSP progress display
			lsp = {
				progress = {
					enabled = true,
					format = "lsp_progress",
					format_done = "lsp_progress_done",
					throttle = 1000 / 30, -- 30fps
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				hover = {
					enabled = true,
					silent = false,
					view = nil,
					opts = {},
				},
				signature = {
					enabled = true,
					auto_open = {
						enabled = true,
						trigger = true,
						luasnip = true,
						throttle = 50,
					},
				},
				message = {
					enabled = true,
					view = "notify",
					opts = {},
				},
			},

			-- Smart routing for different message types
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = { skip = true },
				},
				{
					view = "notify",
					filter = { event = "msg_showmode" },
				},
				{
					filter = {
						event = "msg_show",
						kind = "search_count",
					},
					opts = { skip = true },
				},
				{
					view = "mini",
					filter = {
						event = "msg_show",
						kind = { "echo", "echomsg" },
					},
				},
			},

			-- Presets for common configurations
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
				lsp_doc_border = true,
			},

			-- Views configuration
			views = {
				cmdline_popup = {
					border = {
						style = "rounded",
						padding = { 1, 2 },
					},
					filter_options = {},
					win_options = {
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = "50%",
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
					},
				},
			},

			-- Status line components
			status = {
				command = {
					event = "msg_showcmd",
				},
				message = {
					event = "msg_show",
				},
				ruler = {
					padding = { left = 1, right = 1 },
				},
				search = {
					pattern = "^/",
					icon = "🔍", -- Search icon
				},
			},
		},
		keys = {
			{
				"<S-Enter>",
				function()
					require("noice").redirect(vim.fn.getcmdline())
				end,
				mode = "c",
				desc = "Redirect Cmdline",
			},
			{
				"<leader>nl",
				function()
					require("noice").cmd("last")
				end,
				desc = "Noice Last Message",
			},
			{
				"<leader>nh",
				function()
					require("noice").cmd("history")
				end,
				desc = "Noice History",
			},
			{
				"<leader>na",
				function()
					require("noice").cmd("all")
				end,
				desc = "Noice All",
			},
			{
				"<leader>nd",
				function()
					require("noice").cmd("dismiss")
				end,
				desc = "Dismiss All",
			},
			{
				"<c-f>",
				function()
					if not require("noice.lsp").scroll(4) then
						return "<c-f>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll forward",
				mode = { "i", "n", "s" },
			},
			{
				"<c-b>",
				function()
					if not require("noice.lsp").scroll(-4) then
						return "<c-b>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll backward",
				mode = { "i", "n", "s" },
			},
		},
	},
}
