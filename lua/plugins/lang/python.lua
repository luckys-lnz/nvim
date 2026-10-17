-- Python: basedpyright (types, IntelliSense) + ruff (lint, format, imports)
--         debugpy (F5) · pytest via neotest · venv picker
--
-- Pick your project's virtualenv with <Space>cv — the LSP restarts on it.

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "python", "requirements", "toml", "rst", "ninja" } },
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				basedpyright = {
					settings = {
						basedpyright = {
							disableOrganizeImports = true, -- ruff does it
							analysis = {
								typeCheckingMode = "standard", -- "basic" is quieter, "strict" is louder
								diagnosticMode = "openFilesOnly",
								autoImportCompletions = true,
								inlayHints = {
									variableTypes = true,
									functionReturnTypes = true,
									callArgumentNames = true,
								},
							},
						},
					},
				},
				ruff = {
					on_attach = function(client)
						client.server_capabilities.hoverProvider = false -- basedpyright's hover is richer
					end,
				},
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = { ensure_installed = { "debugpy" } },
	},

	{
		"stevearc/conform.nvim",
		opts = { formatters_by_ft = { python = { "ruff_organize_imports", "ruff_format" } } },
	},

	-- Needs `fd` (Ubuntu: sudo apt install fd-find)
	{
		"linux-cultist/venv-selector.nvim",
		cond = vim.fn.executable("fd") == 1 or vim.fn.executable("fdfind") == 1,
		ft = "python",
		cmd = "VenvSelect",
		keys = { { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select Python venv", ft = "python" } },
		opts = {
			options = {
				notify_user_on_venv_activation = true,
				picker = "snacks",
				fd_binary_name = vim.fn.executable("fd") == 1 and "fd" or "fdfind",
			},
		},
	},

	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = { "mfussenegger/nvim-dap" },
		-- stylua: ignore
		keys = {
			{ "<leader>dPt", function() require("dap-python").test_method() end, desc = "Debug test method", ft = "python" },
			{ "<leader>dPc", function() require("dap-python").test_class() end,  desc = "Debug test class",  ft = "python" },
		},
		config = function()
			-- Mason ships debugpy with its own interpreter; the program being
			-- debugged still runs with the active venv's python.
			require("dap-python").setup(vim.fn.exepath("debugpy-adapter") ~= "" and "debugpy-adapter" or "python3")
		end,
	},

	{
		"nvim-neotest/neotest",
		dependencies = { "nvim-neotest/neotest-python" },
		opts = { adapters = { ["neotest-python"] = { runner = "pytest", dap = { justMyCode = false } } } },
	},
}
