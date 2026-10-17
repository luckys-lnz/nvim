-- Git: change markers in the gutter, hunk actions, side-by-side diffs.
-- Repo-level actions (lazygit, log, branches) live in ui/snacks.lua under <leader>g.

return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "\u{f0da}" },
				topdelete = { text = "\u{f0da}" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "\u{f0da}" },
				topdelete = { text = "\u{f0da}" },
				changedelete = { text = "▎" },
			},
			current_line_blame_opts = { delay = 600 },
			current_line_blame_formatter = " <author> · <author_time:%R> · <summary>",
			on_attach = function(buf)
				local gs = package.loaded.gitsigns
				local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buf, desc = desc }) end

				-- ]h / [h : next / prev change ("hunk")
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next git change")
				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev git change")
				map("n", "]H", function() gs.nav_hunk("last") end, "Last git change")
				map("n", "[H", function() gs.nav_hunk("first") end, "First git change")

				map({ "n", "x" }, "<leader>hs", ":Gitsigns stage_hunk<cr>", "Stage / unstage hunk")
				map({ "n", "x" }, "<leader>hr", ":Gitsigns reset_hunk<cr>", "Reset hunk (discard)")
				map("n", "<leader>hS", gs.stage_buffer, "Stage file")
				map("n", "<leader>hR", gs.reset_buffer, "Reset file (discard)")
				map("n", "<leader>hp", gs.preview_hunk_inline, "Preview hunk inline")
				map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
				map("n", "<leader>hB", function() gs.blame() end, "Blame file")
				map("n", "<leader>hd", gs.diffthis, "Diff against index")
				map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff against last commit")
				map({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<cr>", "Inner hunk (text object)")

				Snacks.toggle({
					name = "Git line blame",
					get = function() return require("gitsigns.config").config.current_line_blame end,
					set = function(state) gs.toggle_current_line_blame(state) end,
				}):map("<leader>ub", { buffer = buf })
			end,
		},
	},

	-- Side-by-side diff & file history (VS Code's diff editor / Timeline)
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff view (working tree)" },
			{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (timeline)" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Repo history" },
		},
		opts = { enhanced_diff_hl = true },
	},
}
