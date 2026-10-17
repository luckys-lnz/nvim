-- GitHub Copilot: ghost-text suggestions + Copilot Chat side panel.
-- First run: :Copilot auth   (one-time browser login)
--
--   Insert mode: <Tab> or <M-l> accept · <M-]>/<M-[> next/prev · <C-]> dismiss
--   <F8> / <Space>aa toggle chat · select code then <Space>ae/af/at/aR/ar

local function chat(prompt)
	return function() require("CopilotChat").ask(prompt) end
end

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			panel = { enabled = false },
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				debounce = 75,
				keymap = { accept = "<M-l>", accept_word = "<M-w>", next = "<M-]>", prev = "<M-[>", dismiss = "<C-]>" },
			},
			filetypes = {
				yaml = false,
				markdown = false,
				help = false,
				gitcommit = false,
				gitrebase = false,
				["."] = false,
			},
		},
		keys = {
			{
				"<leader>uA",
				function()
					require("copilot.suggestion").toggle_auto_trigger()
					vim.notify("Copilot auto-suggestions toggled", vim.log.levels.INFO, { title = "Copilot" })
				end,
				desc = "Toggle Copilot suggestions",
			},
		},
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		cmd = { "CopilotChat", "CopilotChatOpen", "CopilotChatToggle", "CopilotChatModels", "CopilotChatPrompts" },
		dependencies = { "zbirenbaum/copilot.lua", "nvim-lua/plenary.nvim" },
		opts = {
			window = { layout = "vertical", width = 0.4 },
			auto_insert_mode = false,
			headers = { user = "\u{f007} You ", assistant = "\u{f4b8} Copilot ", tool = "\u{f0ad} Tool " },
			prompts = {
				Refactor = { prompt = "Refactor this code to make it cleaner and more maintainable." },
				Fix = { prompt = "Fix issues in this code and keep behavior unchanged." },
				Tests = { prompt = "Generate tests for this code." },
				Explain = { prompt = "Explain the selected code clearly and briefly." },
			},
		},
		-- stylua: ignore
		keys = {
			{ "<F8>",       function() require("CopilotChat").toggle() end, mode = { "n", "i", "t" }, desc = "Copilot Chat (toggle)" },
			{ "<leader>aa", function() require("CopilotChat").toggle() end, mode = { "n", "x" },      desc = "Chat (toggle)" },
			{ "<leader>ax", function() require("CopilotChat").reset() end,  mode = { "n", "x" },      desc = "Chat: clear / reset" },
			{ "<leader>aq", function()
				vim.ui.input({ prompt = "Ask Copilot: " }, function(q) if q and q ~= "" then require("CopilotChat").ask(q) end end)
			end, mode = { "n", "x" }, desc = "Quick question" },
			{ "<leader>ae", chat("/Explain"),  mode = { "n", "x" }, desc = "Explain code" },
			{ "<leader>af", chat("/Fix"),      mode = { "n", "x" }, desc = "Fix code" },
			{ "<leader>at", chat("/Tests"),    mode = { "n", "x" }, desc = "Write tests" },
			{ "<leader>aR", chat("/Refactor"), mode = { "n", "x" }, desc = "Refactor code" },
			{ "<leader>ar", chat("/Review"),   mode = { "n", "x" }, desc = "Review code" },
			{ "<leader>ad", chat("/Docs"),     mode = { "n", "x" }, desc = "Write docs" },
			{ "<leader>ac", chat("/Commit"),   desc = "Write commit message" },
			{ "<leader>ap", "<cmd>CopilotChatPrompts<cr>", mode = { "n", "x" }, desc = "Prompt library" },
			{ "<leader>am", "<cmd>CopilotChatModels<cr>",  desc = "Choose model" },
		},
	},
}
