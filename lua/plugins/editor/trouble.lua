-- Trouble: the "Problems" panel from VS Code (Ctrl+Shift+M), plus symbol outline.

return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = { focus = true, modes = { lsp = { win = { position = "right" } } } },
		-- stylua: ignore
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Problems (workspace)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Problems (this file)" },
			{ "<leader>xs", "<cmd>Trouble symbols toggle<cr>",                  desc = "Symbol outline" },
			{ "<leader>xS", "<cmd>Trouble lsp toggle<cr>",                      desc = "LSP refs/defs (Trouble)" },
			{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix list" },
			{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location list" },
			{ "<C-S-m>",    "<cmd>Trouble diagnostics toggle<cr>",              desc = "Problems (workspace)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then vim.notify(err, vim.log.levels.ERROR) end
					end
				end,
				desc = "Prev problem / quickfix item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then vim.notify(err, vim.log.levels.ERROR) end
					end
				end,
				desc = "Next problem / quickfix item",
			},
		},
	},
}
