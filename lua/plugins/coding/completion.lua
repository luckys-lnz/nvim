-- Completion (VS Code IntelliSense): blink.cmp — fast, Rust fuzzy matcher.
--   <Tab>/<CR> accept · <C-n>/<C-p> or ↑/↓ move (<C-k> is signature help) · <C-Space> open · <C-e> close
--   <C-b>/<C-f> scroll docs · <Tab> also accepts a Copilot ghost suggestion

return {
	{
		"saghen/blink.cmp",
		version = "1.*", -- release tags ship a prebuilt fuzzy-matcher binary
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = { "rafamadriz/friendly-snippets" },
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "enter",
				["<Tab>"] = {
					function(cmp)
						if cmp.is_menu_visible() then return cmp.select_and_accept() end
					end,
					"snippet_forward",
					function() -- accept Copilot ghost text, like VS Code
						local ok, suggestion = pcall(require, "copilot.suggestion")
						if ok and suggestion.is_visible() then
							suggestion.accept()
							return true
						end
					end,
					"fallback",
				},
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},
			appearance = { nerd_font_variant = "mono" },
			completion = {
				accept = { auto_brackets = { enabled = true } },
				list = { selection = { preselect = true, auto_insert = false } },
				menu = {
					border = "rounded",
					draw = {
						treesitter = { "lsp" },
						columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
					},
				},
				documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
				ghost_text = { enabled = false }, -- Copilot owns ghost text
			},
			signature = { enabled = false }, -- noice shows signatures
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					lua = { inherit_defaults = true, "lazydev" },
				},
				providers = {
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},
			cmdline = {
				keymap = { preset = "cmdline", ["<CR>"] = { "accept_and_enter", "fallback" } },
				completion = { menu = { auto_show = true }, list = { selection = { preselect = false } } },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	-- Auto-close brackets and quotes
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = { check_ts = true, disable_filetype = { "snacks_picker_input" }, fast_wrap = { map = "<M-e>" } },
	},

	-- Auto-close and auto-rename HTML / JSX tags
	{ "windwp/nvim-ts-autotag", event = { "BufReadPre", "BufNewFile" }, opts = {} },
}
