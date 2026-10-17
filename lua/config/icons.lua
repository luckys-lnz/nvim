-- Nerd Font icons, written as code points so they survive any editor/font.
-- Look a glyph up at https://www.nerdfonts.com/cheat-sheet (search the hex).

return {
	diagnostics = {
		Error = "\u{f057} ", -- nf-fa-times_circle
		Warn = "\u{f071} ", -- nf-fa-exclamation_triangle
		Info = "\u{f05a} ", -- nf-fa-info_circle
		Hint = "\u{f0eb} ", -- nf-fa-lightbulb_o
	},
	git = {
		added = "\u{f055} ", -- nf-fa-plus_circle
		modified = "\u{f192} ", -- nf-fa-dot_circle_o
		removed = "\u{f056} ", -- nf-fa-minus_circle
		branch = "\u{e725}", -- nf-dev-git_branch
	},
	dap = {
		Stopped = { "\u{f061} ", "DiagnosticWarn", "DapStoppedLine" }, -- nf-fa-arrow_right
		Breakpoint = "\u{f111} ", -- nf-fa-circle
		BreakpointCondition = "\u{f059} ", -- nf-fa-question_circle
		BreakpointRejected = { "\u{f05e} ", "DiagnosticError" }, -- nf-fa-ban
		LogPoint = "\u{f0e7} ", -- nf-fa-bolt
	},
	ui = {
		modified = "\u{25cf}", -- ●
		readonly = "\u{f023}", -- nf-fa-lock
		lsp = "\u{f048b}", -- nf-md-server
		clock = "\u{f017}", -- nf-fa-clock_o
		python = "\u{e73c}", -- nf-dev-python
		lightbulb = "\u{f0eb}", -- nf-fa-lightbulb_o
		guru = "\u{f19d}", -- nf-fa-graduation_cap
		folder = "\u{f07b}",
		folder_open = "\u{f07c}",
		folder_empty = "\u{f114}",
		file = "\u{f15b}",
		close = "\u{f00d}",
		chevron_right = "\u{f054}",
		chevron_down = "\u{f078}",
		record = "\u{f111}",
	},
}
