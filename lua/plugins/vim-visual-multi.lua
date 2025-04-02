return {
	{
		"mg979/vim-visual-multi",
		branch = "master",
		event = "BufReadPost",
		init = function()
			vim.g.VM_default_mappings = 0 -- Disable default mappings to avoid conflicts
			vim.g.VM_maps = {
				-- 🔹 Multi-cursor selection
				["Find Under"] = "<M-n>", -- Select next occurrence (Alt + n)
				["Find Subword Under"] = "<M-n>",
				["Select All"] = "<M-a>", -- Select all occurrences (Alt + a)
				["Skip Next"] = "<M-x>", -- Skip current match (Alt + x)
				["Remove Region"] = "<M-p>", -- Remove selection (Alt + p)

				-- 🔹 Cursor movement within multi-cursor mode
				["Cursor Down"] = "<M-j>", -- Move cursors down (Alt + j)
				["Cursor Up"] = "<M-k>", -- Move cursors up (Alt + k)

				-- 🔹 UI & Navigation
				["Undo"] = "u", -- Undo last multi-cursor edit
				["Redo"] = "<C-r>", -- Redo multi-cursor action

				-- 🔹 Start Multi-cursor Mode
				["Start Regex Search"] = "<M-f>", -- Enter multi-cursor search mode (Alt + f)
				["Visual Add"] = "<M-m>", -- Add multiple cursors in visual mode
				["Visual Find"] = "<M-l>", -- Search for selection in visual mode
			}

			-- 🔹 Additional Enhancements
			vim.g.VM_highlight_matches = "underline" -- Improve visibility of matches
			vim.g.VM_show_warnings = 1 -- Display warnings if there are any issues
		end,
	},
}
