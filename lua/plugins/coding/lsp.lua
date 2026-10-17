-- Language servers (Neovim 0.12 native vim.lsp.config / vim.lsp.enable).
--
-- Language files register servers and tools by extending opts:
--   { "neovim/nvim-lspconfig", opts = { servers = { clangd = { … } } } }
--   { "WhoIsSethDaniel/mason-tool-installer.nvim", opts = { ensure_installed = { "clang-format" } } }
--
-- Only servers listed in opts.servers are enabled, even if Mason has others installed.

local icons = require("config.icons")

---Buffer-local LSP keymaps. Built-ins we keep as-is (Neovim 0.12 defaults):
---  K hover · grn rename · gra code action · grr refs · gri impl · grt type def
---  gO document symbols · <C-s> (insert) signature help is replaced by Save, use <C-k>
local function on_attach(client, buf)
	local function map(lhs, rhs, desc, mode)
		vim.keymap.set(mode or "n", lhs, rhs, { buffer = buf, desc = desc, silent = true })
	end
	local P = Snacks.picker

	-- Go to (VS Code: F12, Shift+F12, Ctrl+F12)
	map("gd", P.lsp_definitions, "Go to definition")
	map("<F12>", P.lsp_definitions, "Go to definition")
	map("gD", P.lsp_declarations, "Go to declaration")
	map("grr", P.lsp_references, "References")
	map("<S-F12>", P.lsp_references, "References")
	map("<F24>", P.lsp_references, "which_key_ignore") -- terminals send Shift+F12 as F24
	map("gri", P.lsp_implementations, "Go to implementation")
	map("<C-F12>", P.lsp_implementations, "Go to implementation")
	map("grt", P.lsp_type_definitions, "Go to type definition")
	map("gK", vim.lsp.buf.signature_help, "Signature help")
	map("<C-k>", vim.lsp.buf.signature_help, "Signature help", "i")

	-- Refactor (VS Code: F2, Ctrl+.)
	vim.keymap.set(
		"n",
		"<F2>",
		function() return ":IncRename " .. vim.fn.expand("<cword>") end,
		{ buffer = buf, expr = true, desc = "Rename symbol" }
	)
	vim.keymap.set(
		"n",
		"<leader>cr",
		function() return ":IncRename " .. vim.fn.expand("<cword>") end,
		{ buffer = buf, expr = true, desc = "Rename symbol" }
	)
	map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" })
	map("<C-.>", vim.lsp.buf.code_action, "Code action", { "n", "x" })
	map(
		"<leader>cA",
		function() vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } }) end,
		"Source action"
	)
	map(
		"<leader>co",
		function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
			})
		end,
		"Organize imports"
	)
	map("<leader>cR", function() Snacks.rename.rename_file() end, "Rename file (updates imports)")
	map("<leader>cc", vim.lsp.codelens.run, "Run code lens", { "n", "x" })

	if client:supports_method("textDocument/inlayHint") then vim.lsp.inlay_hint.enable(true, { bufnr = buf }) end
	if client:supports_method("textDocument/foldingRange") then
		local win = vim.api.nvim_get_current_win()
		vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
	end
end

return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = { ui = { border = "rounded" } },
	},

	-- Installs every server/formatter/debugger the language files ask for.
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = { "mason-org/mason.nvim" },
		cmd = { "MasonToolsInstall", "MasonToolsInstallSync", "MasonToolsUpdate" },
		opts = { ensure_installed = { "tree-sitter-cli" }, run_on_start = true, start_delay = 2000 },
		opts_extend = { "ensure_installed" },
		config = function(_, opts)
			require("mason-tool-installer").setup(opts)
			-- run_on_start fires on VimEnter, which already passed when lazy-loaded
			if opts.run_on_start then vim.defer_fn(function() vim.cmd("MasonToolsInstall") end, opts.start_delay) end
		end,
	},

	{
		"neovim/nvim-lspconfig", -- provides the default server configs in lsp/*.lua
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"saghen/blink.cmp", -- registers completion capabilities for every server
		},
		opts = { servers = {} },
		config = function(_, opts)
			-- Diagnostics look & feel
			local sev = vim.diagnostic.severity
			vim.diagnostic.config({
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
				float = { border = "rounded", source = "if_many" },
				jump = { float = true },
				signs = {
					text = {
						[sev.ERROR] = icons.diagnostics.Error,
						[sev.WARN] = icons.diagnostics.Warn,
						[sev.INFO] = icons.diagnostics.Info,
						[sev.HINT] = icons.diagnostics.Hint,
					},
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if client then on_attach(client, ev.buf) end
				end,
			})

			local names = {}
			for name, cfg in pairs(opts.servers) do
				if cfg ~= false then
					if type(cfg) == "table" and next(cfg) then vim.lsp.config(name, cfg) end
					names[#names + 1] = name
				end
			end
			table.sort(names)

			require("mason-lspconfig").setup({ ensure_installed = names, automatic_enable = false })
			vim.lsp.enable(names)
		end,
	},

	-- Live-preview rename (F2)
	{ "smjonas/inc-rename.nvim", cmd = "IncRename", opts = {} },
}
