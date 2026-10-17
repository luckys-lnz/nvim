-- Formatting (VS Code "Format on Save").  Language files add formatters_by_ft.
--   <Space>cf format now · <Space>uf toggle format-on-save (global) · <Space>uF (buffer)

return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>cf",
				function() require("conform").format({ async = true }) end,
				mode = { "n", "x" },
				desc = "Format",
			},
			{
				"<S-A-f>",
				function() require("conform").format({ async = true }) end,
				mode = { "n", "x" },
				desc = "Format",
			},
			{
				"<leader>cF",
				function() require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 }) end,
				mode = { "n", "x" },
				desc = "Format embedded code",
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				once = true,
				callback = function()
					Snacks.toggle({
						name = "Format on save (global)",
						get = function() return vim.g.autoformat ~= false end,
						set = function(on) vim.g.autoformat = on end,
					}):map("<leader>uf")
					Snacks.toggle({
						name = "Format on save (buffer)",
						get = function() return vim.b.autoformat ~= false and vim.g.autoformat ~= false end,
						set = function(on) vim.b.autoformat = on end,
					}):map("<leader>uF")
				end,
			})
		end,
		opts = {
			default_format_opts = { lsp_format = "fallback" },
			format_on_save = function(buf)
				if vim.g.autoformat == false or vim.b[buf].autoformat == false then return end
				return { timeout_ms = 1500 }
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				["_"] = { "trim_whitespace" },
			},
			formatters = {
				injected = { options = { ignore_errors = true } },
				shfmt = { prepend_args = { "-i", "2" } },
			},
		},
	},
}
