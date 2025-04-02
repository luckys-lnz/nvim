return {
	-- Improved fold UI
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		event = "BufReadPost",
		opts = {
			provider_selector = function(_, _, _)
				return { "lsp", "indent" }
			end,
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end,
		},
		keys = {
			{
				"<leader>oaf", -- Open all folds
				function()
					require("ufo").openAllFolds()
				end,
				desc = "Open all folds",
			},
			{
				"<leader>cof", -- Close all folds
				function()
					require("ufo").closeAllFolds()
				end,
				desc = "Close all folds",
			},
			{
				"<leader>ofk", -- Open folds except kinds
				function()
					require("ufo").openFoldsExceptKinds()
				end,
				desc = "Open folds except kinds",
			},
			{
				"<leader>ofw", -- Close folds with
				function()
					require("ufo").closeFoldsWith()
				end,
				desc = "Close folds with",
			},
			{
				"<leader>pfl", -- Peek folded lines
				function()
					require("ufo").peekFoldedLinesUnderCursor()
				end,
				desc = "Peek folded lines",
			},
			{
				"<leader>tf", -- Toggle fold
				function()
					local current_fold = vim.fn.foldlevel(vim.fn.line("."))
					if current_fold > 0 then
						vim.cmd("foldclose")
					else
						vim.cmd("foldopen")
					end
				end,
				desc = "Toggle fold",
			},
			{
				"<leader>tpf", -- Toggle fold preview
				function()
					-- This will enable preview of folded content
					vim.cmd("normal! zP")
				end,
				desc = "Toggle fold preview",
			},
		},
	},
}
