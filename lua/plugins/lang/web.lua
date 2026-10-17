-- TypeScript · JavaScript · React · Next.js · Tailwind · HTML/CSS · JSON
--
--   vtsls      — the same TypeScript engine VS Code uses
--   eslint     — diagnostics + "fix all" on save (uses the project's eslint)
--   tailwindcss, cssls, html, emmet, jsonls (+ SchemaStore for package.json/tsconfig)
--   prettier   — formatting (prettierd daemon when available)
--   js-debug   — VS Code's debugger: Node, Next.js server, Chrome
--   jest / vitest via neotest

local ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" }

local function ts_action(action)
	return function() vim.lsp.buf.code_action({ apply = true, context = { only = { action }, diagnostics = {} } }) end
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"javascript",
				"typescript",
				"tsx",
				"jsdoc",
				"html",
				"css",
				"scss",
				"json",
				"json5",
				"graphql",
				"prisma",
				"styled",
			},
		},
	},

	{ "b0o/SchemaStore.nvim", lazy = true, version = false },

	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			local inlay = {
				parameterNames = { enabled = "literals" },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = false },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			}
			local lang = {
				updateImportsOnFileMove = { enabled = "always" },
				suggest = { completeFunctionCalls = true },
				inlayHints = inlay,
			}
			opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
				vtsls = {
					settings = {
						complete_function_calls = true,
						vtsls = {
							enableMoveToFileCodeAction = true,
							autoUseWorkspaceTsdk = true, -- use the project's typescript version
							experimental = { completion = { enableServerSideFuzzyMatch = true } },
						},
						typescript = lang,
						javascript = lang,
					},
				},
				eslint = {
					settings = { workingDirectories = { mode = "auto" } },
				},
				tailwindcss = {},
				cssls = {},
				html = {},
				emmet_language_server = {
					filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
				},
				jsonls = {
					before_init = function(_, config)
						config.settings.json.schemas = require("schemastore").json.schemas()
					end,
					settings = { json = { format = { enable = true }, validate = { enable = true } } },
				},
				yamlls = {
					before_init = function(_, config)
						config.settings.yaml.schemas = require("schemastore").yaml.schemas()
					end,
					settings = { yaml = { schemaStore = { enable = false, url = "" }, keyOrdering = false } },
				},
			})
		end,
	},

	-- TypeScript-only refactors (VS Code: "Add all missing imports", …)
	{
		"neovim/nvim-lspconfig",
		-- stylua: ignore
		keys = {
			{ "<leader>cM", ts_action("source.addMissingImports.ts"), desc = "Add missing imports", ft = ft },
			{ "<leader>cu", ts_action("source.removeUnused.ts"),      desc = "Remove unused imports", ft = ft },
			{ "<leader>cD", ts_action("source.fixAll.ts"),            desc = "Fix all TS problems", ft = ft },
		},
	},

	-- ESLint "fix all" before each save (respects <Space>uf / <Space>uF)
	{
		"neovim/nvim-lspconfig",
		init = function()
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("user_eslint_fix", { clear = true }),
				callback = function(ev)
					if vim.g.autoformat == false or vim.b[ev.buf].autoformat == false then return end
					if #vim.lsp.get_clients({ bufnr = ev.buf, name = "eslint" }) > 0 then
						pcall(vim.cmd, "LspEslintFixAll")
					end
				end,
			})
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = { ensure_installed = { "prettierd", "prettier", "js-debug-adapter" } },
	},

	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			local prettier = { "prettierd", "prettier", stop_after_first = true }
			for _, f in ipairs({
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"jsonc",
				"yaml",
				"markdown",
				"graphql",
			}) do
				opts.formatters_by_ft[f] = prettier
			end
		end,
	},

	{
		"mfussenegger/nvim-dap",
		opts = {
			setup = {
				web = function(dap)
					for _, adapter in ipairs({ "pwa-node", "pwa-chrome", "node-terminal" }) do
						dap.adapters[adapter] = {
							type = "server",
							host = "localhost",
							port = "${port}",
							executable = { command = "js-debug-adapter", args = { "${port}" } },
						}
					end
					-- Let .vscode/launch.json files that say "node"/"chrome" work too
					dap.adapters.node = function(cb, config)
						config.type = "pwa-node"
						cb(dap.adapters["pwa-node"])
					end

					local configs = {
						{
							type = "pwa-node",
							request = "launch",
							name = "Node: run this file",
							program = "${file}",
							cwd = "${workspaceFolder}",
							sourceMaps = true,
						},
						{
							type = "pwa-node",
							request = "attach",
							name = "Node: attach to process",
							processId = require("dap.utils").pick_process,
							cwd = "${workspaceFolder}",
						},
						{
							type = "pwa-node",
							request = "launch",
							name = "Next.js: debug server-side",
							runtimeExecutable = "npx",
							runtimeArgs = { "next", "dev" },
							cwd = "${workspaceFolder}",
							sourceMaps = true,
							console = "integratedTerminal",
						},
						{
							type = "pwa-chrome",
							request = "launch",
							name = "Next.js / React: debug in Chrome (localhost:3000)",
							url = function() return vim.fn.input("URL: ", "http://localhost:3000") end,
							webRoot = "${workspaceFolder}",
							sourceMaps = true,
						},
					}
					for _, lang in ipairs(ft) do
						dap.configurations[lang] = configs
					end
				end,
			},
		},
	},

	{
		"nvim-neotest/neotest",
		dependencies = { "nvim-neotest/neotest-jest", "marilari88/neotest-vitest" },
		opts = {
			adapters = {
				["neotest-jest"] = { env = { CI = true } },
				["neotest-vitest"] = {},
			},
		},
	},
}
