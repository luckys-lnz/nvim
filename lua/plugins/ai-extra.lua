-- plugins/ai-extra.lua
return {
	{
		"github/copilot.vim",
	},
	{
		"jackMort/ChatGPT.nvim",
		config = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Cursor-like shortcuts
					vim.keymap.set("n", "<C-L>", function()
						vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n")
					end, { desc = "Accept AI suggestion" })

					-- Quick AI chat with selection
					vim.keymap.set("v", "<C-k>", function()
						local start_pos = vim.fn.getpos("'<")
						local end_pos = vim.fn.getpos("'>")
						local lines = vim.fn.getline(start_pos[2], end_pos[2])
						local selected_text = table.concat(lines, "\n")

						local input = vim.fn.input("Ask AI about selection: ")
						if input ~= "" then
							require("CopilotChat").ask(input .. "\n\nCode:\n``````")
						end
					end, { desc = "Ask AI about selection" })

					-- Cursor-like command palette for AI
					vim.keymap.set("n", "<C-S-p>", function()
						local actions = {
							"ExplainCode",
							"FixCode",
							"OptimizeCode",
							"AddComments",
							"GenerateTests",
							"ReviewCode",
							"RefactorCode",
						}

						vim.ui.select(actions, {
							prompt = "AI Action:",
							format_item = function(item)
								return "🤖 " .. item
							end,
						}, function(choice)
							if choice then
								vim.cmd("CopilotChat" .. choice)
							end
						end)
					end, { desc = "AI Command Palette" })

					-- Auto-format on save with AI suggestions
					vim.api.nvim_create_autocmd("BufWritePre", {
						pattern = "*",
						callback = function()
							if vim.lsp and vim.lsp.buf and vim.lsp.buf.format then
								vim.lsp.buf.format({ async = false })
							end
						end,
					})
				end,
			})
		end,
	},
}
