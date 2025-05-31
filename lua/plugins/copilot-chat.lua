return {
	-- Copilot Chat for AI conversations
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = false, -- Enable debugging
			-- See Configuration section for rest
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			local select = require("CopilotChat.select")

			chat.setup(opts)

			-- Custom prompts for Cursor-like experience
			require("CopilotChat").setup({
				question_header = "## User ",
				answer_header = "## Copilot ",
				error_header = "## Error ",
				prompts = {
					-- Code explanation
					Explain = {
						prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
					},
					-- Code review
					Review = {
						prompt = "/COPILOT_REVIEW Review the selected code.",
						callback = function(response, source)
							-- Custom callback for review
						end,
					},
					-- Fix the code
					Fix = {
						prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.",
					},
					-- Optimize code
					Optimize = {
						prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readability.",
					},
					-- Generate docs
					Docs = {
						prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.",
					},
					-- Generate tests
					Tests = {
						prompt = "/COPILOT_GENERATE Please generate tests for my code.",
					},
					-- Cursor-like quick fixes
					QuickFix = {
						prompt = "/COPILOT_GENERATE Fix any issues in this code and make it production ready.",
					},
					-- Refactor code
					Refactor = {
						prompt = "/COPILOT_GENERATE Refactor this code to make it cleaner and more maintainable.",
					},
					-- Add comments
					AddComments = {
						prompt = "/COPILOT_GENERATE Add helpful comments to explain this code.",
					},
					-- Security review
					Security = {
						prompt = "/COPILOT_REVIEW Review this code for security vulnerabilities and suggest improvements.",
					},
				},
				-- Auto-completion like Cursor
				auto_follow_cursor = false, -- Don't follow the cursor after asking
				auto_insert_mode = false, -- Don't automatically enter insert mode
				insert_at_end = true, -- Insert code at end of buffer
				clear_chat_on_new_prompt = false, -- Keep chat history
				highlight_selection = true, -- Highlight selected code
				highlight_headers = true, -- Highlight headers
				max_line_length = 120, -- Max line length for formatting
			})

			-- Keymaps for Cursor-like experience
			vim.keymap.set("n", "<leader>aa", ":CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" })
			vim.keymap.set("v", "<leader>ae", ":CopilotChatExplain<CR>", { desc = "Explain selection" })
			vim.keymap.set("v", "<leader>ar", ":CopilotChatReview<CR>", { desc = "Review selection" })
			vim.keymap.set("v", "<leader>af", ":CopilotChatFix<CR>", { desc = "Fix selection" })
			vim.keymap.set("v", "<leader>ao", ":CopilotChatOptimize<CR>", { desc = "Optimize selection" })
			vim.keymap.set("v", "<leader>ad", ":CopilotChatDocs<CR>", { desc = "Add docs to selection" })
			vim.keymap.set("v", "<leader>at", ":CopilotChatTests<CR>", { desc = "Generate tests" })
			vim.keymap.set("v", "<leader>aq", ":CopilotChatQuickFix<CR>", { desc = "Quick fix" })
			vim.keymap.set("n", "<leader>ac", ":CopilotChatReset<CR>", { desc = "Clear chat" })

			-- Quick actions like Cursor
			vim.keymap.set("n", "<C-k>", function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { selection = select.buffer })
				end
			end, { desc = "Quick AI Chat" })
		end,
		-- See Commands section for default commands if you want to lazy load on them
	},
}
