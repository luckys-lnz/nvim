return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = { enabled = true, auto_refresh = true },
				suggestion = { enabled = false }, -- We use copilot-cmp instead
				filetypes = {
					markdown = true,
					help = true,
					lua = true,
					python = true,
					javascript = true,
					typescript = true,
					go = true,
					rust = true,
					c = true,
					cpp = true,
					java = true,
					["*"] = false, -- Disable by default
				},
			})

			-- Keybindings
			vim.keymap.set("i", "<C-l>", 'copilot#Accept("")', { expr = true, silent = true })
			vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)", { silent = true })
			vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)", { silent = true })
			vim.keymap.set("i", "<C-x>", "copilot#Dismiss()", { expr = true, silent = true })
			vim.keymap.set("n", "<leader>cp", ":Copilot panel<CR>", { desc = "Open Copilot Panel" })
			vim.keymap.set("n", "<leader>ct", ":Copilot toggle<CR>", { desc = "Toggle Copilot" })
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
	},
}
