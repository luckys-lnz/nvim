return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				vim.o.statusline = " " -- blank until lualine loads (no flash)
			else
				vim.o.laststatus = 0 -- hide on the dashboard
			end
		end,
		config = function()
			vim.o.laststatus = vim.g.lualine_laststatus
			local icons = require("config.icons")
			local c = require("catppuccin.palettes").get_palette()

			local mode_labels = {
				n = "NORMAL",
				i = "INSERT",
				v = "VISUAL",
				V = "V-LINE",
				["\22"] = "V-BLOCK",
				c = "COMMAND",
				R = "REPLACE",
				t = "TERMINAL",
				s = "SELECT",
				S = "S-LINE",
				no = "OP-PEND",
			}
			local function mode_label() return mode_labels[vim.fn.mode()] or vim.fn.mode() end

			-- a/z bookends in the mode colour, b/y raised, c/x at base
			local function mode(color)
				return {
					a = { fg = c.crust, bg = color, gui = "bold" },
					b = { fg = c.text, bg = c.surface0 },
					c = { fg = c.subtext1, bg = c.mantle },
					z = { fg = c.crust, bg = color, gui = "bold" },
				}
			end
			local dim = { fg = c.overlay0, bg = c.mantle }
			local theme = {
				normal = mode(c.blue),
				insert = mode(c.green),
				visual = mode(c.mauve),
				command = mode(c.peach),
				replace = mode(c.red),
				terminal = mode(c.teal),
				inactive = { a = dim, b = dim, c = dim, z = dim },
			}

			-- Rotating keymap tip, drawn from the guru cheatsheet (changes every 15 s)
			local guru = require("guru")
			local function keymap_tip() return icons.ui.lightbulb .. " " .. guru.tip(math.floor(os.time() / 15)) end

			local function lsp_status()
				local names = vim.tbl_map(function(cl) return cl.name end, vim.lsp.get_clients({ bufnr = 0 }))
				if #names == 0 then return "" end
				return icons.ui.lsp .. " " .. table.concat(names, " · ")
			end

			local function macro_rec()
				local reg = vim.fn.reg_recording()
				return reg ~= "" and (icons.ui.record .. " REC @" .. reg) or ""
			end

			local function python_env()
				if vim.bo.filetype ~= "python" then return "" end
				local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_DEFAULT_ENV")
				return venv and (icons.ui.python .. " " .. vim.fn.fnamemodify(venv, ":t")) or ""
			end

			-- Commits ahead of upstream (async, cached 10 s)
			local ahead, ahead_ts = 0, 0
			local function git_ahead()
				local now = vim.uv.now() / 1000
				if now - ahead_ts > 10 then
					ahead_ts = now
					vim.system(
						{ "git", "rev-list", "--count", "@{upstream}..HEAD" },
						{ text = true },
						function(r) ahead = r.code == 0 and (tonumber((r.stdout:gsub("%s+", ""))) or 0) or 0 end
					)
				end
				return ahead > 0 and ("↑" .. ahead) or ""
			end

			-- Working tree dirty? (async, cached 5 s)
			local dirty, dirty_ts = false, 0
			local function commit_sins()
				local now = vim.uv.now() / 1000
				if now - dirty_ts > 5 then
					dirty_ts = now
					vim.system(
						{ "git", "status", "--porcelain" },
						{ text = true },
						function(r) dirty = r.code == 0 and r.stdout ~= "" end
					)
				end
				return dirty and "commit your sins" or "You have no sins, you have been forgiven"
			end

			require("lualine").setup({
				options = {
					theme = theme,
					globalstatus = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "\u{e0b4}", right = "\u{e0b6}" },
					disabled_filetypes = { statusline = { "snacks_dashboard" } },
					refresh = { statusline = 1000 },
				},
				sections = {
					lualine_a = { { mode_label, separator = { left = "\u{e0b6}", right = "\u{e0b4}" } } },
					lualine_b = {
						{ "branch", icon = icons.git.branch, color = { fg = c.lavender, gui = "bold" } },
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							diff_color = {
								added = { fg = c.green },
								modified = { fg = c.yellow },
								removed = { fg = c.red },
							},
						},
						{ git_ahead, color = { fg = c.sapphire, gui = "bold" } },
					},
					lualine_c = {
						{
							"filename",
							path = 1,
							symbols = {
								modified = " " .. icons.ui.modified,
								readonly = " " .. icons.ui.readonly,
								unnamed = "[No Name]",
								newfile = " [New]",
							},
							color = { fg = c.text },
						},
						{
							commit_sins,
							color = function() return { fg = dirty and c.peach or c.overlay1, gui = "italic" } end,
							padding = { left = 2, right = 1 },
						},
						{
							keymap_tip,
							color = { fg = c.sky, gui = "italic" },
							padding = { left = 2, right = 1 },
							cond = function() return vim.o.columns > 140 end,
						},
					},
					lualine_x = {
						{ macro_rec, color = { fg = c.red, gui = "bold" } },
						{ python_env, color = { fg = c.green, gui = "italic" } },
						{ "filetype", color = { fg = c.subtext1 } },
					},
					lualine_y = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
							diagnostics_color = {
								error = { fg = c.red },
								warn = { fg = c.yellow },
								info = { fg = c.sky },
								hint = { fg = c.teal },
							},
						},
						{ "location", color = { fg = c.sapphire } },
					},
					lualine_z = {
						{ lsp_status },
						{
							function() return icons.ui.clock .. " " .. os.date("%H:%M") end,
							separator = { right = "\u{e0b4}" },
						},
					},
				},
				inactive_sections = {
					lualine_c = { { "filename", path = 1, color = { fg = c.overlay1 } } },
					lualine_x = { { "location", color = { fg = c.overlay1 } } },
				},
				extensions = { "lazy", "mason", "neo-tree", "nvim-dap-ui", "quickfix", "trouble", "man" },
			})
		end,
	},
}
