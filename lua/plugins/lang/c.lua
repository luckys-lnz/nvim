-- C (and C++): clangd (IntelliSense, clang-tidy) · clang-format · codelldb / gdb (F5)
--
-- clangd needs to know your compiler flags. Generate compile_commands.json:
--   CMake : cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && ln -s build/compile_commands.json .
--   Make  : bear -- make
--   tiny  : a `compile_flags.txt` with one flag per line (e.g. -Iinclude, -std=c17)

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "c", "cpp", "make", "cmake", "doxygen", "printf" } },
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
					-- utf-16 keeps clangd and Copilot agreeing on positions
					capabilities = { offsetEncoding = { "utf-16" } },
					init_options = { usePlaceholders = true, completeUnimported = true, clangdFileStatus = true },
				},
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = { ensure_installed = { "clang-format", "codelldb" } },
	},

	{
		"stevearc/conform.nvim",
		opts = { formatters_by_ft = { c = { "clang-format" }, cpp = { "clang-format" } } },
	},

	-- Header ⇄ source switch (VS Code: Alt+O in the C/C++ extension)
	{
		"neovim/nvim-lspconfig",
		keys = {
			{
				"<leader>ch",
				"<cmd>LspClangdSwitchSourceHeader<cr>",
				desc = "Switch header/source (C)",
				ft = { "c", "cpp" },
			},
			{ "<A-o>", "<cmd>LspClangdSwitchSourceHeader<cr>", desc = "Switch header/source (C)", ft = { "c", "cpp" } },
		},
	},

	{
		"mfussenegger/nvim-dap",
		opts = {
			setup = {
				c = function(dap)
					dap.adapters.codelldb = { type = "executable", command = "codelldb" }
					-- GDB 14+ speaks DAP natively
					dap.adapters.gdb = {
						type = "executable",
						command = "gdb",
						args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
					}

					local function program() return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file") end
					local configs = {
						{
							name = "Launch (codelldb)",
							type = "codelldb",
							request = "launch",
							program = program,
							cwd = "${workspaceFolder}",
							stopOnEntry = false,
						},
						{
							name = "Launch (gdb)",
							type = "gdb",
							request = "launch",
							program = program,
							cwd = "${workspaceFolder}",
							stopAtBeginningOfMainSubprogram = false,
						},
						{
							name = "Attach to process (codelldb)",
							type = "codelldb",
							request = "attach",
							pid = require("dap.utils").pick_process,
							cwd = "${workspaceFolder}",
						},
					}
					dap.configurations.c = configs
					dap.configurations.cpp = configs
				end,
			},
		},
	},
}
