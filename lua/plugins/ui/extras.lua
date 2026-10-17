-- Small VS Code look-and-feel touches.

return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "MunifTanjim/nui.nvim", lazy = true },

	-- Breadcrumbs bar on top of each window (VS Code breadcrumbs). Clickable.
	{
		"Bekaboo/dropbar.nvim",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "<leader>;", function() require("dropbar.api").pick() end, desc = "Pick breadcrumb symbol" },
		},
		opts = {},
	},

	-- 💡 in the sign column when a code action is available (VS Code lightbulb)
	{
		"kosayoda/nvim-lightbulb",
		event = "LspAttach",
		opts = {
			autocmd = { enabled = true },
			sign = { enabled = true, text = "\u{f0eb}", lens_text = "\u{f0eb}", hl = "DiagnosticWarn" },
			ignore = { clients = { "ruff" } },
		},
	},

	-- Peek window: look at a definition without leaving your file (VS Code Alt+F12)
	{
		"dnlhc/glance.nvim",
		cmd = "Glance",
		keys = {
			{ "gpd", "<cmd>Glance definitions<cr>", desc = "Peek definition" },
			{ "gpr", "<cmd>Glance references<cr>", desc = "Peek references" },
			{ "gpi", "<cmd>Glance implementations<cr>", desc = "Peek implementations" },
			{ "gpt", "<cmd>Glance type_definitions<cr>", desc = "Peek type definition" },
			{ "<A-F12>", "<cmd>Glance definitions<cr>", desc = "Peek definition" },
		},
		opts = {
			border = { enable = true, top_char = "─", bottom_char = "─" },
			hooks = {
				before_open = function(results, open, jump)
					if #results == 1 then
						jump(results[1])
					else
						open(results)
					end
				end,
			},
		},
	},

	-- Optional training wheels: blocks hjkl-spamming and suggests better motions.
	-- Off by default; <Space>uH turns it on when you want to practise.
	{
		"m4xshen/hardtime.nvim",
		cmd = "Hardtime",
		dependencies = { "MunifTanjim/nui.nvim" },
		keys = {
			{
				"<leader>uH",
				function()
					vim.cmd("Hardtime toggle")
					vim.notify(
						"Hardtime " .. (require("hardtime").is_plugin_enabled and "on" or "off"),
						vim.log.levels.INFO
					)
				end,
				desc = "Toggle Hardtime (motion trainer)",
			},
		},
		opts = {
			enabled = false,
			disable_mouse = false,
			disabled_filetypes = { "neo-tree", "lazy", "mason", "snacks_dashboard" },
		},
	},
}
