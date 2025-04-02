return {
	-- VS Code-like todo comments
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
			{ "<leader>tx", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
			{ "<leader>Tx", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
			{ "<leader>tS", "<cmd>TodoTelescope<cr>", desc = "Todo" },
			{ "<leader>Ts", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
			-- adding Todo
			{
				"<leader>tda",
				"oTODO: ",
				desc = "Add TODO comment",
				mode = "n",
			},
			{
				"<leader>tdf",
				"oFIX: ",
				desc = "Add FIX comment",
				mode = "n",
			},
			{
				"<leader>tdn",
				"oNOTE: ",
				desc = "Add NOTE comment",
				mode = "n",
			},
			{
				"<leader>tdb",
				"oDEBUG: ",
				desc = "Add DEBUG comment",
				mode = "n",
			},
			{
				"<leader>tdw",
				"oWARNING: ",
				desc = "Add WARNING comment",
				mode = "n",
			},
			{
				"<leader>tdi",
				"oIMPORTANT: ",
				desc = "Add IMPORTANT comment",
				mode = "n",
			},
		},
	},
}
