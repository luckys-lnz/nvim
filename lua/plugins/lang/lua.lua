-- Lua — only so this config itself has completion, docs and formatting.

return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							completion = { callSnippet = "Replace" },
							hint = { enable = true, arrayIndex = "Disable" },
							telemetry = { enable = false },
						},
					},
				},
			},
		},
	},

	-- Neovim API types and plugin docs for lua_ls
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = { ensure_installed = { "stylua" } },
	},
}
