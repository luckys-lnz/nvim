-- lua/plugins/colorschemes.lua
return {
	-- Core Themes (lazy loaded unless selected)
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "folke/tokyonight.nvim", name = "tokyonight" },
	{ "shaunsingh/nord.nvim", name = "nord" },
	{ "savq/melange-nvim", name = "melange" },
	{ "EdenEast/nightfox.nvim", name = "nightfox" },
	{ "sainnhe/sonokai", name = "sonokai" },
	{ "sainnhe/everforest", name = "everforest" },
	{ "ellisonleao/gruvbox.nvim", config = true, opts = ... },

	-- Theme Manager
	{
		"nvim-lua/plenary.nvim", -- required for some theme plugins
		lazy = true,
	},

	{
		"theme-manager",
		priority = 1000,
		init = function()
			vim.g.colors_name = "tokyonight" -- default theme
		end,
		config = function()
			local themes = {
				catppuccin = {
					setup = function()
						require("catppuccin").setup({
							flavor = "mocha",
							transparent_background = true,
							term_colors = true,
							dim_inactive = {
								enabled = false,
								shade = "dark",
								percentage = 0.15,
							},
							styles = {
								comments = { "italic" },
								conditionals = { "italic" },
							},
							integrations = {
								cmp = true,
								gitsigns = true,
								treesitter = true,
								which_key = true,
								dap = { enabled = true, enable_ui = true },
								native_lsp = {
									enabled = true,
									virtual_text = {
										errors = { "italic" },
										hints = { "italic" },
										warnings = { "italic" },
										information = { "italic" },
									},
									underlines = {
										errors = { "underline" },
										hints = { "underline" },
										warnings = { "underline" },
										information = { "underline" },
									},
								},
							},
						})
					end,
				},

				tokyonight = {
					setup = function()
						require("tokyonight").setup({
							style = "storm", -- "storm", "moon", "night", "day"
							light_style = "day", -- used when `background` is "light"
							transparent = true,
							terminal_colors = true,
							dim_inactive = false, -- dims inactive windows
							lualine_bold = true,

							styles = {
								comments = { italic = true },
								keywords = { italic = true },
								functions = { bold = true },
								variables = {},
							},

							sidebars = { "qf", "vista_kind", "terminal", "packer" },
							day_brightness = 0.3, -- for "day" style

							hide_inactive_statusline = false,
							cache = false,
							plugins = {
								cmp = true,
								gitsigns = true,
								notify = true,
								nvimtree = true,
								telescope = true,
								treesitter = true,
								lsp_trouble = true,
								which_key = true,
							},

							on_colors = function(colors) end,
							on_highlights = function(highlights, colors) end,
						})
					end,
				},

				gruvbox = {
					setup = function()
						require("gruvbox").setup({
							transparent_mode = true,
							italic = {
								strings = true,
								comments = true,
								keywords = true,
								functions = true,
							},
						})
					end,
				},

				nightfox = {
					setup = function()
						require("nightfox").setup({})
					end,
				},

				nord = {
					setup = function()
						-- Minimal config; plugin works out-of-the-box
					end,
				},

				sonokai = {
					setup = function()
						vim.g.sonokai_style = "default"
					end,
				},

				everforest = {
					setup = function()
						vim.g.everforest_background = "hard"
						vim.g.everforest_enable_italic = 1
					end,
				},

				melange = {
					setup = function()
						-- No config required for melange
					end,
				},
			}

			local function switch_theme(theme)
				local ok = themes[theme]
				if not ok then
					vim.notify("Invalid theme: " .. theme, vim.log.levels.ERROR)
					return
				end
				if themes[theme].setup then
					themes[theme].setup()
				end
				vim.cmd.colorscheme(theme)
			end

			-- Initialize default theme
			switch_theme(vim.g.colors_name or "tokyonight")

			-- :SwitchTheme command
			vim.api.nvim_create_user_command("SwitchTheme", function(opts)
				switch_theme(opts.args)
			end, {
				nargs = 1,
				complete = function()
					return vim.tbl_keys(themes)
				end,
			})
		end,
	},
}
