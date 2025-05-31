return {
	-- Inline AI completions (similar to Cursor's inline editing)
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
				-- Enable/disable codeium
				enable_chat = true,
				-- Virtual text configuration
				virtual_text = {
					enabled = true,
					manual = false,
					default_filetype_enabled = true,
					idle_delay = 75,
					virtual_text_priority = 65535,
					map_keys = true,
					accept_fallback = nil,
					key_bindings = {
						accept = "<Tab>",
						accept_word = "<C-Right>",
						accept_line = "<C-Down>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
			})
		end,
	},
}
