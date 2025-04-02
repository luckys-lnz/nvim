return {
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			-- Toggle Trouble panel
			{ "<leader>tt", "<cmd>TroubleToggle<cr>", desc = " Toggle Trouble Panel" },

			-- Diagnostics
			{ "<leader>tdl", "<cmd>TroubleToggle document_diagnostics<cr>", desc = " Document Diagnostics" },
			{ "<leader>twl", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = " Workspace Diagnostics" },

			-- Lists
			{ "<leader>tll", "<cmd>TroubleToggle loclist<cr>", desc = " Location List" },
			{ "<leader>tql", "<cmd>TroubleToggle quickfix<cr>", desc = " Quickfix List" },

			-- Navigation
			{
				"[t",
				function()
					if require("trouble").is_open() then
						require("trouble").previous({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = " Previous Trouble Item",
			},
			{
				"]t",
				function()
					local trouble = require("trouble")
					if trouble.is_open() then
						local current_node = trouble.view:get_selected() or {} -- Prevent errors when no node is selected
						trouble.next({ skip_groups = true, jump = true }, { item = {}, node = current_node, opts = {} })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = " Next Trouble Item",
			},
		},
	},
}
