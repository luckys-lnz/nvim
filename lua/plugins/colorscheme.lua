return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Base Colors for the Ultimate Visual Vibe
			local colors = {
				fg = "#C9C7CD",
				bg = "#1F1F1F", -- Dark, but sleek
				red = "#FF5F6D", -- Electric red
				green = "#A8E6CF", -- Soft neon green
				blue = "#42A5F5", -- Futuristic sky blue
				yellow = "#FFEB3B", -- Solar yellow
				purple = "#9C27B0", -- Cosmic purple
				cyan = "#00BCD4", -- Oceanic cyan
				gray = "#2C3E50", -- Techy gray
				bg_dark = "#212121", -- Darkened mode bg for contrast
				highlight = "#FF4081", -- Highlight color for active elements
				mode_change = "#673AB7", -- Mode change animation color
			}

			-- Smooth transition for modes
			local mode_colors = {
				n = colors.red,
				i = colors.green,
				v = colors.purple,
				V = colors.purple,
				c = colors.blue,
				no = colors.red,
				s = colors.yellow,
				S = colors.yellow,
				ic = colors.blue,
				R = colors.green,
				Rv = colors.purple,
				t = colors.cyan,
			}

			-- Function to generate a gradient transition for the background
			local function dynamic_bg()
				return {
					fg = colors.fg,
					bg = string.format(
						"#%02X%02X%02X",
						math.random(150, 255),
						math.random(100, 255),
						math.random(100, 200)
					),
				}
			end

			-- LSP status (with extra flair)
			local function lsp_status()
				local bufnr = vim.api.nvim_get_current_buf()
				local clients = vim.lsp.get_clients({ bufnr = bufnr })
				if not clients or #clients == 0 then
					return "⚡ No LSP"
				end
				local names = {}
				for _, c in ipairs(clients) do
					if c.name ~= "null-ls" then
						table.insert(names, c.name)
					end
				end
				return "⚡ " .. table.concat(names, ", ")
			end

			-- Animated Mode Change Effect (like pulsing animation)
			local function mode_pulse()
				local current_mode = vim.fn.mode()
				return {
					fg = colors.bg,
					bg = mode_colors[current_mode] or colors.highlight,
					gui = "bold",
				}
			end

			-- Custom System Stats
			local function system_stats()
				local cpu_usage = io.popen("top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}'"):read("*a"):gsub("\n", "")
				local ram_usage = io.popen("free -h | grep Mem | awk '{print $3}'"):read("*a"):gsub("\n", "")
				local disk_usage = io.popen("df -h | grep /dev/sda1 | awk '{print $5}'"):read("*a"):gsub("\n", "")
				return string.format(
					"🧠 %.1f%% CPU | 💾 %s RAM |  %s Disk",
					tonumber(cpu_usage),
					ram_usage,
					disk_usage
				)
			end

			-- Apply the insane lualine setup
			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
					icons_enabled = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = { statusline = { "neo-tree" }, winbar = {} },
				},
				sections = {
					lualine_a = {
						{
							"mode",
							icon = "",
							color = mode_pulse,
							separator = { left = "", right = "" },
						},
					},
					lualine_b = {
						{
							"branch",
							icon = "",
							color = { fg = colors.bg, bg = colors.green, gui = "bold" },
							separator = { left = "", right = "" },
						},
						{ "diff", symbols = { added = "+", modified = "~", removed = "-" }, colored = true },
					},
					lualine_c = {
						{
							"filename",
							path = 1,
							color = { fg = colors.fg, bg = colors.blue, gui = "bold" },
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
							color = { bg = colors.gray },
						},
					},
					lualine_x = {
						{
							"encoding",
							color = { fg = colors.green },
							separator = { left = "", right = "" },
						},
						{
							"fileformat",
							symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
							color = { fg = colors.cyan },
						},
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
						system_stats,
						separator = { left = "", right = "" },
						color = { fg = colors.bg, bg = colors.purple, gui = "italic,bold" },
					},
					{
						lsp_status,
						separator = { left = "", right = "" },
						color = { fg = colors.bg_dark, bg = colors.cyan, gui = "italic,bold" },
					},
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
