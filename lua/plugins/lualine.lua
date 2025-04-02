return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- Icons support
		opts = {
			options = {
				theme = "auto",
				globalstatus = true,
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { statusline = { "neo-tree" }, winbar = {} },
			},
			extensions = { "neo-tree", "lazy", "quickfix", "man", "toggleterm" },
		},
		config = function()
			local colors = {
				bg = "#161617",
				fg = "#c9c7cd",
				blue = "#92a2d5",
				red = "#ea83a5",
				green = "#90b99f",
				yellow = "#e6b99d",
				purple = "#aca1cf",
				cyan = "#85b5ba",
				gray2 = "#2a2a2c",
				bg_dark = "#131314",
			}

			local mode_colors = {
				n = colors.red,
				i = colors.cyan,
				v = colors.purple,
				V = colors.red,
				c = colors.yellow,
				no = colors.red,
				s = colors.yellow,
				S = colors.yellow,
				ic = colors.yellow,
				R = colors.green,
				Rv = colors.purple,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				["!"] = colors.red,
				t = colors.red,
			}

			local mode = {
				"mode",
				color = function()
					return { bg = mode_colors[vim.fn.mode()], fg = colors.bg_dark, gui = "bold" }
				end,
				separator = { left = "", right = "" },
			}

			local branch = {
				"branch",
				icon = "",
				color = { bg = colors.green, fg = colors.bg, gui = "bold" },
				separator = { left = "", right = "" },
			}

			local filetype = {
				"filetype",
				icons_enabled = true,
				color = { bg = colors.gray2, fg = colors.blue, gui = "italic,bold" },
				separator = { left = "", right = "" },
			}

			local filename = {
				"filename",
				color = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				separator = { left = "", right = "" },
			}

			local location = {
				"location",
				color = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				separator = { left = "", right = "" },
			}

			local diagnostics = {
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
				diagnostics_color = {
					error = { fg = colors.red },
					warn = { fg = colors.yellow },
					info = { fg = colors.purple },
					hint = { fg = colors.cyan },
				},
				color = { bg = colors.gray2, fg = colors.blue, gui = "bold" },
				separator = { left = "", right = "" },
			}

			local function lsp_status()
				local bufnr = vim.api.nvim_get_current_buf()
				local clients = vim.lsp.get_clients({ bufnr = bufnr })
				if next(clients) == nil then
					return "  No LSP"
				end
				local client_names = {}
				for _, client in pairs(clients) do
					if client.name ~= "null-ls" then
						table.insert(client_names, client.name)
					end
				end
				return "  " .. table.concat(client_names, ", ")
			end

			local lsp = {
				lsp_status,
				separator = { left = "", right = "" },
				color = { bg = colors.purple, fg = colors.bg, gui = "italic,bold" },
			}

			local overseer = {
				"overseer",
				color = { fg = colors.red, bg = colors.bg_dark, gui = "italic,bold" },
			}

			require("lualine").setup({
				sections = {
					lualine_a = { mode },
					lualine_b = { branch },
					lualine_c = { filetype, filename, location },
					lualine_x = { overseer },
					lualine_y = { diagnostics },
					lualine_z = { lsp },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				extensions = { "neo-tree", "lazy", "quickfix", "man", "toggleterm" }, -- ensure neo-tree extension is always loadedu
			})
		end,
	},
}
