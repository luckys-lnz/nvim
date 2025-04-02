return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "" }, -- Plus sign for additions
				change = { text = "" }, -- Pencil for changes
				delete = { text = "󰍵" }, -- Trash bin for deletions
				topdelete = { text = "󰍵" },
				changedelete = { text = "󰏦" }, -- Modified delete icon
				untracked = { text = "" }, -- Question mark for untracked files
			},
			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
			watch_gitdir = { interval = 1000, follow_files = true },
			attach_to_untracked = true,
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 1000,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = " <author> - <author_time:%Y-%m-%d> | <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
			max_file_length = 40000,
			preview_config = {
				border = "rounded",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			yadm = { enable = false }, -- Explicitly disable yadm if not needed

			-- Hook for attaching key mappings and other actions
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, lhs, rhs, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, lhs, rhs, opts)
				end

				-- Navigation between hunks
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(gs.next_hunk)
					return "<Ignore>"
				end, { expr = true, desc = "󰊢 Next Git Hunk" })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(gs.prev_hunk)
					return "<Ignore>"
				end, { expr = true, desc = "󰊢 Previous Git Hunk" })

				-- Git actions (stage, reset, etc.)
				map("n", "<leader>gs", gs.stage_hunk, { desc = " Stage Hunk" })
				map("n", "<leader>gr", gs.reset_hunk, { desc = "󰅖 Reset Hunk" })
				map("v", "<leader>gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = " Stage Hunk (Visual)" })
				map("v", "<leader>gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "󰅖 Reset Hunk (Visual)" })
				map("n", "<leader>gS", gs.stage_buffer, { desc = " Stage Entire Buffer" })
				map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "󰅖 Undo Last Staged Hunk" })
				map("n", "<leader>gR", gs.reset_buffer, { desc = "󰅖 Reset Entire Buffer" })
				map("n", "<leader>gp", gs.preview_hunk, { desc = " Preview Hunk Changes" })
				map("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end, { desc = "󰬘 Show Git Blame" })
				map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "󰬘 Toggle Line Blame" })
				map("n", "<leader>gd", gs.diffthis, { desc = "󰩄 Show Diff (Current)" })
				map("n", "<leader>gD", function()
					gs.diffthis("~")
				end, { desc = "󰩄 Show Diff (Last Commit)" })
				map("n", "<leader>td", gs.toggle_deleted, { desc = "󰍶 Toggle Deleted Lines" })

				-- Git text objects
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = " Select Git Hunk" })
			end,
		},
	},
}
