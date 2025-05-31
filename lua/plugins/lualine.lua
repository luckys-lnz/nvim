return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local colors = {
				bg = "#0a0a0a",
				fg = "#c9c7cd",
				blue = "#6272a4",
				red = "#ff5555",
				green = "#50fa7b",
				yellow = "#f1fa8c",
				purple = "#bd93f9",
				cyan = "#8be9fd",
				orange = "#ffb86c",
				pink = "#ff79c6",
				gray = "#44475a",
				gray2 = "#282a36",
				bg_dark = "#000000",
				blood_red = "#8b0000",
				ghost_white = "#f8f8ff",
				tomb_gray = "#2f2f2f",
			}

			-- Creepy quotes function
			local function creepy_quote()
				local quotes = {
					"ᚠᚢᚦᚨᚱᚲ: the old runes whisper",
					"echo $DOOM",
					"alias vim='neovim.exe'",
					"rm -rf ~/.sanity",
					":wq and pray 🙏",
					"👀 Watch your back",
					"⬅️spell doom backwards",
					"0xDEAD ☠ 0xBEEF",
					"Another day, another curse",
					"🔨 𝔠𝔯𝔲𝔰𝔥 𝔦𝔱 𝔡𝔬𝔴𝔫",
					"Death is just the beginning ⚰️",
					"whisper DOOM to summon the darkness 🪦",
					"The void stares back at you 👁️",
					"sudo rm -rf /hope",
					"Memory leak detected in soul.exe",
					"404: Happiness not found",
					"Segmentation fault in reality",
					"Warning: Undefined behavior ahead",
					"Stack overflow in dreams",
					"NULL pointer to happiness",
					"Buffer overflow in emotions",
					"Race condition with destiny",
					"Deadlock in life.thread",
					"Exception: SanityNotFoundException",
				}
				local index = math.floor(vim.loop.hrtime() / 3e9) % #quotes + 1
				return quotes[index]
			end

			-- Cursed mode display
			local function cursed_mode()
				local modes = {
					n = "☠️ NORMAL",
					i = "👻 INSERT",
					v = "🔪 VISUAL",
					V = "🔪 V·LINE",
					["\22"] = "🔪 V·BLOCK",
					c = "💀 COMMAND",
					R = "🔁 REPLACE",
					t = "🧪 TERMINAL",
					s = "🐍 SELECT",
					S = "🐍 S·LINE",
					[""] = "🐍 S·BLOCK",
				}
				local current_mode = vim.fn.mode()
				local mode_display = modes[current_mode] or "👀 UNKNOWN"
				return mode_display
			end

			-- Check git status and return appropriate creepy message
			local function commit_sins()
				-- Check if we're in a git repository
				local handle = io.popen("git rev-parse --is-inside-work-tree 2>/dev/null")
				local is_git_repo = handle:read("*a"):gsub("%s+", "")
				handle:close()

				if is_git_repo ~= "true" then
					return "🕊️ You have no sins"
				end

				-- Check for uncommitted changes
				local status_handle = io.popen("git -C " .. vim.fn.getcwd() .. " status --porcelain 2>/dev/null")
				local output = status_handle:read("*a")
				status_handle:close()

				if output and output ~= "" then
					return "🧎 commit your sins 🙏 ... " .. creepy_quote()
				end

				return creepy_quote()
			end

			-- Enhanced LSP status with creepy twist
			local function lsp_status()
				local bufnr = vim.api.nvim_get_current_buf()
				local clients = vim.lsp.get_clients({ bufnr = bufnr })
				if not clients or #clients == 0 then
					return "👻 No LSP Spirits"
				end
				local names = {}
				for _, c in ipairs(clients) do
					if c.name ~= "null-ls" then
						table.insert(names, c.name)
					end
				end
				return "🔮 " .. table.concat(names, ", ")
			end

			-- Macro recording with creepy style
			local function macro_recording()
				local reg = vim.fn.reg_recording()
				if reg == "" then
					return ""
				end
				return "🔴 Cursing @" .. reg
			end

			-- Python environment with snake emoji
			local function python_venv()
				local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
				if venv then
					return "🐍 " .. vim.fn.fnamemodify(venv, ":t")
				end
				return ""
			end

			-- Creepy diagnostics counter
			local function diagnostic_counter()
				local levels = {
					[vim.diagnostic.severity.ERROR] = { icon = "💀", name = "errors" },
					[vim.diagnostic.severity.WARN] = { icon = "⚠️", name = "warnings" },
					[vim.diagnostic.severity.INFO] = { icon = "👁️", name = "info" },
					[vim.diagnostic.severity.HINT] = { icon = "💡", name = "hints" },
				}

				local counts = {}
				for severity, config in pairs(levels) do
					counts[config.name] = #vim.diagnostic.get(0, { severity = severity })
				end

				local total_issues = counts.errors + counts.warnings + counts.info + counts.hints
				if total_issues == 0 then
					return "✨ Pure Code"
				end

				return string.format(
					"💀%d ⚠️%d 👁️%d 💡%d",
					counts.errors,
					counts.warnings,
					counts.info,
					counts.hints
				)
			end

			-- Mode-based color scheme
			local mode_colors = {
				n = colors.red,
				i = colors.cyan,
				v = colors.purple,
				V = colors.purple,
				["\22"] = colors.purple,
				c = colors.yellow,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				ic = colors.yellow,
				R = colors.green,
				Rv = colors.purple,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				["!"] = colors.red,
				t = colors.pink,
			}

			-- Custom theme with darker colors
			local custom_theme = {
				normal = {
					a = { fg = colors.bg_dark, bg = colors.red, gui = "bold" },
					b = { fg = colors.fg, bg = colors.gray },
					c = { fg = colors.fg, bg = colors.bg_dark },
				},
				insert = { a = { fg = colors.bg_dark, bg = colors.cyan, gui = "bold" } },
				visual = { a = { fg = colors.bg_dark, bg = colors.purple, gui = "bold" } },
				command = { a = { fg = colors.bg_dark, bg = colors.yellow, gui = "bold" } },
				replace = { a = { fg = colors.bg_dark, bg = colors.green, gui = "bold" } },
				terminal = { a = { fg = colors.bg_dark, bg = colors.pink, gui = "bold" } },
				inactive = {
					a = { fg = colors.gray, bg = colors.bg_dark },
					b = { fg = colors.gray, bg = colors.bg_dark },
					c = { fg = colors.gray, bg = colors.bg_dark },
				},
			}

			require("lualine").setup({
				options = {
					theme = custom_theme,
					globalstatus = true,
					icons_enabled = true,
					component_separators = { left = "│", right = "│" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = { "neo-tree", "alpha", "dashboard" },
						winbar = {},
					},
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = {
						{
							cursed_mode,
							color = function()
								return {
									fg = colors.bg_dark,
									bg = mode_colors[vim.fn.mode()] or colors.green,
									gui = "bold",
								}
							end,
							separator = { left = "", right = "" },
							padding = { left = 1, right = 1 },
						},
					},
					lualine_b = {
						{
							"branch",
							icon = "",
							color = { fg = colors.bg_dark, bg = colors.green, gui = "bold" },
							separator = { left = "", right = "" },
						},
						{
							"diff",
							symbols = { added = "🟢", modified = "🟡", removed = "🔴" },
							colored = true,
							diff_color = {
								added = { fg = colors.green },
								modified = { fg = colors.yellow },
								removed = { fg = colors.red },
							},
						},
					},
					lualine_c = {
						{
							"filename",
							path = 1,
							symbols = {
								modified = " 🔥",
								readonly = " 🔒",
								unnamed = " 👻",
								newfile = " ✨",
							},
							color = { fg = colors.bg_dark, bg = colors.blue, gui = "bold" },
							separator = { left = "", right = "" },
						},
						{
							commit_sins,
							color = { fg = colors.ghost_white, gui = "italic" },
							separator = { left = " ", right = " " },
						},
					},
					lualine_x = {
						{
							macro_recording,
							color = { fg = colors.blood_red, gui = "bold,italic" },
						},
						{
							python_venv,
							color = { fg = colors.green, gui = "italic" },
						},
						{
							"filetype",
							icon_only = false,
							colored = true,
							separator = { left = "", right = "" },
							color = { bg = colors.purple, fg = colors.bg_dark, gui = "bold" },
						},
						{
							"fileformat",
							symbols = { unix = "🐧", dos = "🪟", mac = "🍎" },
							color = { fg = colors.cyan },
						},
						{
							"encoding",
							color = { fg = colors.green },
							fmt = function(str)
								return str:upper()
							end,
						},
					},
					lualine_y = {
						{
							diagnostic_counter,
							color = { fg = colors.ghost_white, bg = colors.tomb_gray, gui = "bold" },
							separator = { left = "", right = "" },
						},
						{
							"location",
							icon = "📍",
							color = { fg = colors.bg_dark, bg = colors.yellow, gui = "bold" },
							separator = { left = "", right = "" },
						},
						{
							"progress",
							icon = "⚡",
							color = { fg = colors.bg_dark, bg = colors.orange, gui = "bold" },
							separator = { left = "", right = "" },
						},
					},
					lualine_z = {
						{
							function()
								return "🕐 " .. os.date("%H:%M")
							end,
							color = { fg = colors.bg_dark, bg = colors.cyan, gui = "bold" },
							separator = { left = "", right = "" },
						},
						{
							lsp_status,
							separator = { left = "", right = "" },
							color = { fg = colors.bg_dark, bg = colors.pink, gui = "bold" },
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						{
							"filename",
							path = 1,
							color = { fg = colors.gray },
							symbols = {
								modified = " 💀",
								readonly = " 🔒",
							},
						},
					},
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {
					"lazy",
					"neo-tree",
					"quickfix",
					"toggleterm",
					"man",
					"fugitive",
					"nvim-dap-ui",
					"trouble",
					"fzf",
				},
			})
		end,
	},
}
