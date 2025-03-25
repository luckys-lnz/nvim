-- lua/plugins/editor.lua
-- Editor enhancements for a VS Code-like experience

return {

	-- VS Code-like lazygit integration
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- VS Code-like multi-cursor
	{
		"mg979/vim-visual-multi",
		event = "BufReadPost",
		init = function()
			vim.g.VM_maps = {
				["Find Under"] = "<C-d>",
				["Find Subword Under"] = "<C-d>",
			}
		end,
	},

	-- VS Code-like comment
	{
		"numToStr/Comment.nvim",
		event = "BufReadPost",
		opts = {
			padding = true,
			sticky = true,
			toggler = {
				line = "gcc",
				block = "gbc",
			},
			opleader = {
				line = "gc",
				block = "gb",
			},
			extra = {
				above = "gcO",
				below = "gco",
				eol = "gcA",
			},
			mappings = {
				basic = true,
				extra = true,
			},
			pre_hook = nil,
			post_hook = nil,
		},
	},

	-- VS Code-like surround
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "BufReadPost",
		opts = {
			keymaps = {
				insert = "<C-g>s",
				insert_line = "<C-g>S",
				normal = "ys",
				normal_cur = "yss",
				normal_line = "yS",
				normal_cur_line = "ySS",
				visual = "S",
				visual_line = "gS",
				delete = "ds",
				change = "cs",
			},
		},
	},

	-- VS Code-like autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
				java = false,
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0,
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel",
				highlight_grey = "LineNr",
			},
		},
	},

	-- VS Code-like session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
			options = { "buffers", "curdir", "tabpages", "winsize" },
		},
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore Session",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore Last Session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Don't Save Current Session",
			},
		},
	},

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
				"<leader>ta",
				"oTODO: ",
				desc = "Add TODO comment",
				mode = "n",
			},
			{
				"<leader>tf",
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
				"<leader>td",
				"oDEBUG: ",
				desc = "Add DEBUG comment",
				mode = "n",
			},
			{
				"<leader>tw",
				"oWARNING: ",
				desc = "Add WARNING comment",
				mode = "n",
			},
			{
				"<leader>ai",
				"oIMPORTANT: ",
				desc = "Add IMPORTANT comment",
				mode = "n",
			},
		},
	},

	-- VS Code-like trouble diagnostics
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
			{ "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
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
				desc = "Previous trouble/quickfix item",
			},

			{
				"]q",
				function()
					local trouble = require("trouble")
					if trouble.is_open() then
						-- Fetch the current node dynamically if possible
						local current_node = trouble.view:get_selected() or {} -- Fallback to an empty table if no node is selected

						trouble.next({ skip_groups = true, jump = true }, {
							item = {},
							node = current_node, -- Pass a real node if available
							opts = {},
						})
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next trouble/quickfix item",
			},
		},
	},
}
