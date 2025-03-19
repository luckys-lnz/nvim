-- lua/plugins/extras/lang/go.lua
-- Go specific configuration

return {
	-- Add Go specific language support
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				gopls = {
					settings = {
						gopls = {
							gofumpt = true,
							codelenses = {
								gc_details = false,
								generate = true,
								regenerate_cgo = true,
								run_govulncheck = true,
								test = true,
								tidy = true,
								upgrade_dependency = true,
								vendor = true,
							},
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
							analyses = {
								fieldalignment = true,
								nilness = true,
								unusedparams = true,
								unusedwrite = true,
								useany = true,
							},
							usePlaceholders = true,
							completeUnimported = true,
							staticcheck = true,
							directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
							semanticTokens = true,
						},
					},
				},
			},
		},
	},

	-- Go tools
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			--[[       lsp_cfg = false, -- we use the lspconfig setup ]]
			lsp_gofumpt = true,
			lsp_on_attach = function(_, bufnr)
				local function buf_map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end
				-- Go specific mappings
				buf_map("n", "<leader>gsj", function()
					require("go.impl").impl()
				end, "Add interface stubs")
				buf_map("n", "<leader>gst", function()
					require("go.alternate").toggle()
				end, "Toggle test file")
			end,
			lsp_document_formatting = false,
			lsp_inlay_hints = {
				enable = true,
			},
			diagnostic = {
				hdlr = true,
				underline = true,
				virtual_text = { space = 0, prefix = "●" },
				signs = true,
			},
			dap_debug = true,
			dap_debug_gui = true,
			test_runner = "go", -- richgo, go test, richgo, dlv, ginkgo
		},
		config = function(_, opts)
			require("go").setup(opts)
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
	},

	-- Go test runner
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/neotest-go",
		},
		opts = {
			adapters = {
				["neotest-go"] = {
					-- Here you can specify the settings for the adapter
					args = { "-count=1", "-timeout=60s" },
				},
			},
		},
	},
}
