return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "storm", -- storm, moon, night, day
		light_style = "day",
		transparent = false,
		terminal_colors = true,
		styles = {
			comments = { italic = true },
			keywords = { italic = true },
			functions = { bold = true },
			variables = {},
			sidebars = "dark", -- dark, transparent, normal
			floats = "dark", -- dark, transparent, normal
		},
		sidebars = { "qf", "help", "vista_kind", "terminal", "packer" },
		day_brightness = 0.3,
		hide_inactive_statusline = false,
		dim_inactive = false,
		lualine_bold = false,

		-- Custom color overrides
		on_colors = function(colors)
			-- Enhance colors for better visibility
			colors.bg_dark = "#16161e"
			colors.bg_float = "#16161e"
			colors.comment = "#565f89"
			colors.purple = "#bb9af7"
			colors.cyan = "#7dcfff"
			colors.blue1 = "#2ac3de"
			colors.orange = "#ff9e64"
			colors.yellow = "#e0af68"
			colors.green = "#9ece6a"
			colors.red = "#f7768e"
		end,

		-- Detailed highlight customizations
		on_highlights = function(hl, c)
			-- Cursor and line numbers
			hl.CursorLineNr = { fg = c.purple, bold = true }
			hl.LineNr = { fg = c.blue1 }
			hl.LineNrAbove = { fg = c.comment }
			hl.LineNrBelow = { fg = c.comment }
			hl.CursorLine = { bg = c.bg_dark }
			hl.CursorColumn = { bg = c.bg_dark }

			-- Visual selections
			hl.Visual = { bg = "#364A82" }
			hl.VisualNOS = { bg = "#364A82" }

			-- Search highlights
			hl.Search = { bg = c.yellow, fg = c.black }
			hl.IncSearch = { bg = c.orange, fg = c.black }
			hl.CurSearch = { bg = c.red, fg = c.black }

			-- Matching parentheses
			hl.MatchParen = { fg = c.orange, bold = true }

			-- Statusline enhancements
			hl.StatusLine = { fg = c.fg, bg = c.bg_dark }
			hl.StatusLineNC = { fg = c.comment, bg = c.bg_dark }

			-- Tabline
			hl.TabLine = { fg = c.comment, bg = c.bg_dark }
			hl.TabLineFill = { bg = c.black }
			hl.TabLineSel = { fg = c.fg, bg = c.blue1 }

			-- Floating windows
			hl.NormalFloat = { fg = c.fg, bg = c.bg_float }
			hl.FloatBorder = { fg = c.blue1, bg = c.bg_float }
			hl.FloatTitle = { fg = c.purple, bg = c.bg_float, bold = true }

			-- Popup menu
			hl.Pmenu = { fg = c.fg, bg = c.bg_dark }
			hl.PmenuSel = { fg = c.black, bg = c.blue1 }
			hl.PmenuSbar = { bg = c.comment }
			hl.PmenuThumb = { bg = c.blue1 }

			-- Diagnostic highlights
			hl.DiagnosticError = { fg = c.red }
			hl.DiagnosticWarn = { fg = c.yellow }
			hl.DiagnosticInfo = { fg = c.blue1 }
			hl.DiagnosticHint = { fg = c.cyan }
			hl.DiagnosticUnnecessary = { fg = c.comment, italic = true }

			-- Git signs
			hl.GitSignsAdd = { fg = c.green }
			hl.GitSignsChange = { fg = c.yellow }
			hl.GitSignsDelete = { fg = c.red }

			-- Telescope
			hl.TelescopeNormal = { fg = c.fg, bg = c.bg_float }
			hl.TelescopeBorder = { fg = c.blue1, bg = c.bg_float }
			hl.TelescopeTitle = { fg = c.purple, bold = true }
			hl.TelescopeSelection = { fg = c.fg, bg = c.bg_highlight }
			hl.TelescopeMatching = { fg = c.orange, bold = true }

			-- Indent guides
			hl.IndentBlanklineChar = { fg = "#2a2e36" }
			hl.IndentBlanklineContextChar = { fg = c.purple }

			-- Neo-tree
			hl.NeoTreeNormal = { fg = c.fg, bg = c.bg_sidebar }
			hl.NeoTreeNormalNC = { fg = c.fg, bg = c.bg_sidebar }
			hl.NeoTreeDirectoryIcon = { fg = c.blue1 }
			hl.NeoTreeDirectoryName = { fg = c.blue1 }
			hl.NeoTreeFileName = { fg = c.fg }
			hl.NeoTreeFileIcon = { fg = c.fg }
			hl.NeoTreeRootName = { fg = c.purple, bold = true }
			hl.NeoTreeGitAdded = { fg = c.green }
			hl.NeoTreeGitDeleted = { fg = c.red }
			hl.NeoTreeGitModified = { fg = c.yellow }

			-- Which-key
			hl.WhichKey = { fg = c.cyan }
			hl.WhichKeyGroup = { fg = c.blue1 }
			hl.WhichKeyDesc = { fg = c.fg }
			hl.WhichKeySeparator = { fg = c.comment }
			hl.WhichKeyFloat = { bg = c.bg_float }

			-- Notify
			hl.NotifyBackground = { bg = c.bg }
			hl.NotifyERRORBorder = { fg = c.red }
			hl.NotifyWARNBorder = { fg = c.yellow }
			hl.NotifyINFOBorder = { fg = c.blue1 }
			hl.NotifyDEBUGBorder = { fg = c.comment }
			hl.NotifyTRACEBorder = { fg = c.purple }

			-- Treesitter context
			hl.TreesitterContext = { bg = c.bg_dark }
			hl.TreesitterContextLineNumber = { fg = c.purple, bg = c.bg_dark }

			-- Syntax enhancements
			hl["@variable"] = { fg = c.fg }
			hl["@variable.builtin"] = { fg = c.red, italic = true }
			hl["@constant"] = { fg = c.orange }
			hl["@constant.builtin"] = { fg = c.orange, italic = true }
			hl["@string"] = { fg = c.green }
			hl["@string.escape"] = { fg = c.cyan }
			hl["@character"] = { fg = c.green }
			hl["@number"] = { fg = c.orange }
			hl["@boolean"] = { fg = c.orange }
			hl["@function"] = { fg = c.blue, bold = true }
			hl["@function.builtin"] = { fg = c.cyan, bold = true }
			hl["@keyword"] = { fg = c.purple, italic = true }
			hl["@keyword.function"] = { fg = c.purple, italic = true }
			hl["@keyword.return"] = { fg = c.purple, italic = true }
			hl["@type"] = { fg = c.blue1 }
			hl["@type.builtin"] = { fg = c.blue1, italic = true }
			hl["@namespace"] = { fg = c.cyan }
			hl["@property"] = { fg = c.green1 }
			hl["@attribute"] = { fg = c.yellow }
			hl["@tag"] = { fg = c.red }
			hl["@tag.attribute"] = { fg = c.yellow }
			hl["@tag.delimiter"] = { fg = c.blue7 }
		end,
	},

	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme("tokyonight")

		-- Additional post-setup customizations
		vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#565f89" })
		vim.api.nvim_set_hl(0, "VertSplit", { fg = "#565f89" })

		-- Set up autocmd for dynamic adjustments
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "tokyonight*",
			callback = function()
				-- Ensure our custom highlights persist
				local colors = require("tokyonight.colors").setup()
				vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.purple, bold = true })
				vim.api.nvim_set_hl(0, "LineNr", { fg = colors.blue1 })
			end,
		})
	end,
}
