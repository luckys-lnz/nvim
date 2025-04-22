return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local colors = {
				bg = "#161617",
				fg = "#c9c7cd",
				blue = "#92a2d5",
				red = "#ea83a5",
				green = "#90b99f",
				yellow = "#e6b99d",
				purple = "#aca1cf",
				cyan = "#85b5ba",
				gray2 = "#2a2a2c",
				bg_dark = "#131314",
			}

			local mode_colors = {
				n = colors.red,
				i = colors.cyan,
				v = colors.purple,
				V = colors.purple,
				["␖"] = colors.purple,
				c = colors.yellow,
				no = colors.red,
				s = colors.yellow,
				S = colors.yellow,
				ic = colors.yellow,
				R = colors.green,
				Rv = colors.purple,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				["!"] = colors.red,
				t = colors.red,
			}

			local function lsp_status()
				local bufnr = vim.api.nvim_get_current_buf()
				local clients = vim.lsp.get_clients({ bufnr = bufnr })
				if not clients or #clients == 0 then
					return "  No LSP"
				end
				local names = {}
				for _, c in ipairs(clients) do
					if c.name ~= "null-ls" then
						table.insert(names, c.name)
					end
				end
				return "  " .. table.concat(names, ", ")
			end

			local function macro_recording()
				local reg = vim.fn.reg_recording()
				if reg == "" then
					return ""
				end
				return "🔴 Rec @" .. reg
			end

			local function python_venv()
				local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
				return venv and ("🐍 " .. vim.fn.fnamemodify(venv, ":t")) or ""
			end

			local custom_theme = require("lualine.themes.auto")
			custom_theme.normal.c.bg = colors.bg_dark

			require("lualine").setup({
				options = {
					theme = custom_theme,
					globalstatus = true,
					icons_enabled = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = { statusline = { "neo-tree" }, winbar = {} },
				},
				sections = {
					lualine_a = {
						{
							"mode",
							icon = "",
							color = function()
								return {
									fg = colors.bg_dark,
									bg = mode_colors[vim.fn.mode()] or colors.green,
									gui = "bold",
								}
							end,
							separator = { left = "", right = "" },
						},
					},
					lualine_b = {
						{
							"branch",
							icon = "",
							color = { fg = colors.bg_dark, bg = colors.green, gui = "bold" },
							separator = { left = "", right = "" },
						},
						{ "diff", symbols = { added = "+", modified = "~", removed = "-" }, colored = true },
					},
					lualine_c = {
						{
							"filename",
							path = 1, -- smart path
							color = { fg = colors.bg, bg = colors.blue, gui = "bold" },
							separator = { left = "", right = "" },
						},
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " ", hint = " " },
							diagnostics_color = {
								error = { fg = colors.red },
								warn = { fg = colors.yellow },
								info = { fg = colors.blue },
								hint = { fg = colors.cyan },
							},
							separator = { left = "", right = "" },
							color = { bg = colors.gray2 },
						},
					},
					lualine_x = {
						{ macro_recording, color = { fg = colors.red, gui = "italic" } },
						{ python_venv, color = { fg = colors.yellow } },
						{
							"filetype",
							icon_only = false,
							colored = true,
							separator = { left = "", right = "" },
							color = { bg = colors.purple, fg = colors.bg, gui = "bold" },
						},
						{
							"fileformat",
							symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
							color = { fg = colors.cyan },
						},
						{ "encoding", color = { fg = colors.green } },
					},
					lualine_y = {
						{
							"location",
							color = { fg = colors.bg_dark, bg = colors.yellow, gui = "bold" },
							separator = { left = "", right = "" },
						},
					},
				},
				lualine_z = {
					{
						function()
							return os.date(" %H:%M")
						end,
						color = { fg = colors.green, gui = "bold" },
						separator = { left = "", right = "" },
					},
					{
						function()
							local levels = { errors = 1, warnings = 2, info = 3, hints = 4 }
							local counts = {}
							for k, v in pairs(levels) do
								counts[k] = #vim.diagnostic.get(0, { severity = v })
							end
							return string.format(
								" %d  %d  %d  %d",
								counts.errors,
								counts.warnings,
								counts.info,
								counts.hints
							)
						end,
						color = { fg = colors.red, gui = "bold" },
						separator = { left = "", right = "" },
					},
					{
						function()
							local handle = io.popen("top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}'")
							local cpu_usage = handle:read("*a")
							handle:close()
							cpu_usage = tonumber(cpu_usage)
							if cpu_usage then
								return string.format("🧠 %.1f%% CPU", cpu_usage)
							else
								return "🧠 CPU N/A"
							end
						end,
						color = { fg = colors.purple },
						separator = { left = "", right = "" },
					},
					{
						lsp_status,
						separator = { left = "", right = "" },
						color = { fg = colors.bg_dark, bg = colors.cyan, gui = "italic,bold" },
					},
				},
				inactive_sections = {
					lualine_c = {
						{
							"filename",
							path = 1,
							color = { fg = colors.fg },
						},
					},
					lualine_x = { "location" },
				},
				extensions = {
					"lazy",
					"neo-tree",
					"quickfix",
					"toggleterm",
					"man",
					"fugitive",
					"nvim-dap-ui",
				},
			})
		end,
	},
}
