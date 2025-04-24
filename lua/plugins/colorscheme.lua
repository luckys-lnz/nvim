return {
	"tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "storm",
		styles = {
			sidebars = "dark",
			floats = "dark",
		},
		on_highlights = function(hl, c)
			hl.CursorLineNr.fg = c.purple
			hl.LineNr.fg = c.blue
			hl.LineNrNC.fg = c.blue
			hl.CursorLine.fg = c.bg_dark
			hl.CursorLine.bg = c.bg_dark
		end,
	},
	config = function(_, opts)
		vim.cmd.colorscheme("tokyonight")
		require("tokyonight").setup(opts)
	end,
}
