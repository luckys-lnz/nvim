-- lua/plugins/extras/lang/typescript.lua
-- TypeScript specific configuration

return {
	-- Add TypeScript specific language support
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				-- Ensure TypeScript LSP is configured
				ts_lsr = {
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
							format = {
								indentSize = 2,
								convertTabsToSpaces = true,
								tabSize = 2,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
							format = {
								indentSize = 2,
								convertTabsToSpaces = true,
								tabSize = 2,
							},
						},
						completions = {
							completeFunctionCalls = true,
						},
					},
				},
			},
		},
	},

	-- TypeScript tools
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			settings = {
				-- spawn additional tsserver for specific directories
				separate_diagnostic_server = true,
				-- "change"|"insert_leave" determine when the client asks the server about diagnostic
				publish_diagnostic_on = "insert_leave",
				-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
				-- "remove_unused_imports"|"organize_imports") -- or string "all"
				-- to include all supported code actions
				-- specify commands exposed as code_actions
				expose_as_code_action = "all",
				-- string|nil - specify a custom path to tsserver.js file,
				-- e.g. "/path/to/node_modules/typescript/lib/tsserver.js"
				-- this is useful for some monorepos or non-standard typescript installations
				tsserver_path = nil,
				-- string|nil - specify a custom path to tsserver.js file,
				-- e.g. "/path/to/node_modules/typescript/lib/tsserver.js"
				-- this is useful for some monorepos or non-standard typescript installations
				tsserver_plugins = {},
				-- whether to enable debug logging for the plugin and if enabled what
				-- should be logged
				debug = false,
			},
		},
	},

	-- Better ESLint integration
	{
		"MunifTanjim/eslint.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = {
			bin = "eslint_d", -- or `eslint`
			code_actions = {
				enable = true,
				apply_on_save = {
					enable = true,
					types = { "directive", "problem", "suggestion", "layout" },
				},
				disable_rule_comment = {
					enable = true,
					location = "separate_line", -- or `same_line`
				},
			},
			diagnostics = {
				enable = true,
				report_unused_disable_directives = false,
				run_on = "type", -- or `save`
			},
		},
	},
}
