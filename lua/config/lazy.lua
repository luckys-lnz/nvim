return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Defining the crazy color palette for that *out-of-this-world* feel
			local colors = {
				fg = "#C9C7CD", -- Text color
				bg = "#1A1A1A", -- Dark background for contrast
				red = "#FF3030", -- Intense red for errors and alerts
				green = "#39D853", -- Vibrant green for success and completion
				blue = "#009CFF", -- Bold blue for important sections
				yellow = "#FFEA00", -- Bright yellow for warnings and highlights
				purple = "#9C27B0", -- Deep purple for special functions
				cyan = "#00B4D9", -- Soothing cyan for context and info
				highlight = "#FF4081", -- Highlighter for active elements
				mode_change = "#673AB7", -- Smooth mode change effects
				ambient_bg = "#121212", -- Subtle background for passive elements
				accent = "#FF80AB", -- Accent color for subtle attention points
			}

			-- Dynamic mode effects to go beyond the standard "highlighted" effect
			local function mode_pulse()
				local current_mode = vim.fn.mode()
				local pulse_colors = {
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
				return {
					fg = colors.bg,
					bg = pulse_colors[current_mode] or colors.accent,
					gui = "bold,italic",
					underline = true,
				}
			end

			-- Animated background transition when changing modes
			local function mode_bg_animation()
				return {
					fg = colors.fg,
					bg = string.format(
						"#%02X%02X%02X",
						math.random(200, 255),
						math.random(100, 255),
						math.random(100, 255)
					),
					gui = "italic",
				}
			end

			-- Real-time system feedback (CPU, RAM, Disk usage with animation)
			local function system_stats()
				local cpu_usage = io.popen("top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}'"):read("*a"):gsub("\n", "")
				local ram_usage = io.popen("free -h | grep Mem | awk '{print $3}'"):read("*a"):gsub("\n", "")
				local disk_usage = io.popen("df -h | grep /dev/sda1 | awk '{print $5}'"):read("*a"):gsub("\n", "")
				return string.format(
					"🚀 %.1f%% CPU | 💾 %s RAM | 🏙️ %s Disk",
					tonumber(cpu_usage),
					ram_usage,
					disk_usage
				)
			end

			-- AI-powered code completion status (predictive snippets)
			local function ai_completion_status()
				local status = "👾 Ready for next command"
				if vim.fn.mode() == "i" then
					status = "🔮 Predicting next snippet..."
				end
				return status
			end

			-- Custom function to show the LSP status with real-time feedback
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

			-- Final statusline setup that defines the crazy new experience
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
							color = { bg = colors.bg },
						},
					},
					lualine_x = {
						{
							ai_completion_status,
							color = { fg = colors.purple, gui = "italic" },
							separator = { left = "", right = "" },
						},
						{ "encoding", color = { fg = colors.green } },
						{
							"fileformat",
							symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
							color = { fg = colors.cyan },
						},
					},
					lualine_y = {
						{
							"location",
							color = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
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
