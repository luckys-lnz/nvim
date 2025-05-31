-- lsp lua configuration

return {
	-- VS Code-like LSP setup
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", opts = {} },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{
				"hrsh7th/cmp-nvim-lsp",
				cond = function()
					return require("utils").has("nvim-cmp")
				end,
			},
		},
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				severity_sort = true,
			},
			inlay_hints = {
				enabled = false,
			},
			capabilities = {},
			autoformat = true,
			format_notify = false,
			format = {
				formatting_options = nil,
				timeout_ms = 3000,
			},
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								callSnippet = "Replace",
							},
							telemetry = {
								enable = false,
							},
							hint = {
								enable = true,
							},
						},
					},
				},
				pyright = {
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "basic",
								diagnosticMode = "workspace",
								inlayHints = {
									variableTypes = true,
									functionReturnTypes = true,
								},
							},
						},
					},
				},
				ts_ls = {
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
						},
					},
				},
				html = {},
				cssls = {},
				jsonls = {},
				yamlls = {},
				marksman = {},
				tailwindcss = {},
				clangd = {},
			},
			setup = {
				-- example to setup with typescript.nvim
				-- tsserver = function(_, opts)
				--   require("typescript").setup({ server = opts })
				--   return true
				-- end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
		config = function(_, opts)
			local Util = require("utils")

			-- setup autoformat
			Util.format.register(Util.lsp.formatter())

			-- setup keymaps
			Util.lsp.on_attach(function(client, buffer)
				require("plugins.lsp.keymaps").on_attach(client, buffer)
			end)

			-- diagnostics
			vim.diagnostic.config(opts.diagnostics)

			local servers = opts.servers
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities(),
				opts.capabilities or {}
			)

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			-- get all the servers that are available through mason-lspconfig
			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local all_mslp_servers = {}
			if have_mason then
				-- Fixed: Use the correct API to get available servers
				local success, available_servers = pcall(mlsp.get_available_servers)
				if success then
					all_mslp_servers = available_servers
				else
					-- Fallback: try alternative method
					local mapping_success, mappings = pcall(require, "mason-lspconfig.mappings")
					if mapping_success and mappings and mappings.server then
						all_mslp_servers = vim.tbl_keys(mappings.server)
					elseif mapping_success and mappings and mappings.lspconfig_to_package then
						all_mslp_servers = vim.tbl_keys(mappings.lspconfig_to_package)
					else
						-- Final fallback: manually define common servers
						all_mslp_servers = {
							"lua_ls",
							"pyright",
							"ts_ls",
							"html",
							"cssls",
							"jsonls",
							"yamlls",
							"marksman",
							"tailwindcss",
							"clangd",
							"rust_analyzer",
							"gopls",
							"bashls",
							"vimls",
							"dockerls",
							"eslint",
						}
					end
				end
			end

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			if have_mason then
				mlsp.setup({
					ensure_installed = ensure_installed,
					handlers = { setup },
					automatic_installation = true, -- Enable automatic installation of LSP servers
				})
			end

			if Util.lsp.get_config("denols") and Util.lsp.get_config("ts_ls") then
				local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
				Util.lsp.disable("ts_ls", is_deno)
				Util.lsp.disable("denols", function(root_dir)
					return not is_deno(root_dir)
				end)
			end
		end,
	},
}
