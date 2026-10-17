return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			flavour = "mocha",
			background = { light = "latte", dark = "mocha" },
			term_colors = true,
			dim_inactive = { enabled = true, shade = "dark", percentage = 0.15 },
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				keywords = { "italic" },
				booleans = { "italic" },
			},
			-- Detect installed plugins and theme them automatically.
			auto_integrations = true,
			integrations = {
				snacks = { enabled = true, indent_scope_color = "lavender" },
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
					inlay_hints = { background = true },
				},
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
		end,
		keys = {
			{
				"<leader>uT",
				function()
					local light = (vim.g.colors_name or ""):find("latte")
					vim.cmd.colorscheme(light and "catppuccin-mocha" or "catppuccin-latte")
				end,
				desc = "Toggle dark/light theme",
			},
		},
	},
}
