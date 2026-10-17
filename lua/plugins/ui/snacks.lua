-- snacks.nvim: one plugin replacing ~10 (dashboard, picker, notifier, terminal,
-- lazygit, indent guides, input/select UI, buffer delete, zoom, toggles…).

-- Project-wide search uses ripgrep; without it, fall back to `git grep`.
local function grep()
	if vim.fn.executable("rg") == 1 then
		Snacks.picker.grep()
	else
		Snacks.picker.git_grep()
	end
end

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true }, -- disables heavy features on huge files
			quickfile = { enabled = true },
			input = { enabled = true }, -- pretty vim.ui.input (rename prompts, …)
			notifier = { enabled = true, timeout = 3000, style = "compact", top_down = false },
			indent = { enabled = true, animate = { enabled = false } },
			scope = { enabled = true },
			words = { enabled = true }, -- highlight other uses of the word under cursor
			statuscolumn = { enabled = true },
			scroll = { enabled = false },
			picker = {
				enabled = true,
				ui_select = true, -- vim.ui.select (code actions, etc.) uses the picker
				layout = { preset = "default" },
				sources = {
					files = { hidden = true },
					grep = { hidden = true },
					explorer = { hidden = true },
				},
				win = {
					input = {
						keys = {
							-- VS Code-ish: Ctrl+j/k move in the list as well as ↑/↓
							["<C-j>"] = { "list_down", mode = { "i", "n" } },
							["<C-k>"] = { "list_up", mode = { "i", "n" } },
						},
					},
				},
			},
			terminal = { win = { position = "float", border = "rounded" } },
			lazygit = { configure = true },
			dashboard = {
				preset = {
					header = table.concat({
						"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
						"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
						"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
						"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
						"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
						"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
					}, "\n"),
					-- stylua: ignore
					keys = {
						{ icon = "\u{f002} ", key = "f", desc = "Find file",        action = ":lua Snacks.picker.smart()" },
						{ icon = "\u{f15b} ", key = "n", desc = "New file",         action = ":ene | startinsert" },
						{ icon = "\u{f00e} ", key = "g", desc = "Find text",        action = grep },
						{ icon = "\u{f1da} ", key = "r", desc = "Recent files",     action = ":lua Snacks.picker.recent()" },
						{ icon = "\u{f0e8} ", key = "s", desc = "Restore session",  section = "session" },
						{ icon = "\u{f19d} ", key = "?", desc = "Guru cheatsheet",  action = ":lua require('guru').open()" },
						{ icon = "\u{f013} ", key = "c", desc = "Config",           action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
						{ icon = "\u{f0ad} ", key = "m", desc = "Mason (tools)",    action = ":Mason" },
						{ icon = "\u{f1de} ", key = "l", desc = "Lazy (plugins)",   action = ":Lazy" },
						{ icon = "\u{f011} ", key = "q", desc = "Quit",             action = ":qa" },
					},
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{
						text = { { "\u{f0eb}  " .. require("guru").tip(), hl = "SnacksDashboardDesc" } },
						align = "center",
						padding = 1,
					},
					{ section = "startup" },
				},
			},
		},
		-- stylua: ignore
		keys = {
			-- ── Find (VS Code: Ctrl+P, Ctrl+Shift+P, Ctrl+Shift+F) ──────────────
			{ "<C-p>",           function() Snacks.picker.files() end,                 desc = "Find files" },
			{ "<C-S-p>",         function() Snacks.picker.commands() end,              desc = "Command palette" },
			{ "<leader><space>", function() Snacks.picker.smart() end,                 desc = "Smart find (buffers+recent+files)" },
			{ "<leader>/",       grep,                  desc = "Search in project (grep)" },
			{ "<leader>,",       function() Snacks.picker.buffers() end,               desc = "Open buffers" },
			{ "<leader>ff",      function() Snacks.picker.files() end,                 desc = "Files" },
			{ "<leader>fr",      function() Snacks.picker.recent() end,                desc = "Recent files" },
			{ "<leader>fb",      function() Snacks.picker.buffers() end,               desc = "Buffers" },
			{ "<leader>fg",      function() Snacks.picker.git_files() end,             desc = "Git files" },
			{ "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Config files" },
			{ "<leader>ft",      function() Snacks.terminal() end,                     desc = "Terminal (float)" },
			-- ── Search ───────────────────────────────────────────────────────────
			{ "<leader>sg",      grep,                  desc = "Grep" },
			{ "<leader>sw",      function() Snacks.picker.grep_word() end,             desc = "Word under cursor / selection", mode = { "n", "x" } },
			{ "<leader>sb",      function() Snacks.picker.lines() end,                 desc = "Lines in buffer" },
			{ "<leader>ss",      function() Snacks.picker.lsp_symbols() end,           desc = "Symbols in file" },
			{ "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end, desc = "Symbols in workspace" },
			{ "<leader>sd",      function() Snacks.picker.diagnostics() end,           desc = "Diagnostics (all)" },
			{ "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,    desc = "Diagnostics (buffer)" },
			{ "<leader>sc",      function() Snacks.picker.commands() end,              desc = "Commands" },
			{ "<leader>s:",      function() Snacks.picker.command_history() end,       desc = "Command history" },
			{ "<leader>sk",      function() Snacks.picker.keymaps() end,               desc = "Keymaps (all)" },
			{ "<leader>sh",      function() Snacks.picker.help() end,                  desc = "Help pages" },
			{ "<leader>sm",      function() Snacks.picker.marks() end,                 desc = "Marks" },
			{ "<leader>sj",      function() Snacks.picker.jumps() end,                 desc = "Jump list" },
			{ "<leader>su",      function() Snacks.picker.undo() end,                  desc = "Undo history" },
			{ "<leader>sq",      function() Snacks.picker.qflist() end,                desc = "Quickfix list" },
			{ "<leader>sr",      function() Snacks.picker.resume() end,                desc = "Resume last search" },
			{ "<leader>sn",      function() Snacks.notifier.show_history() end,        desc = "Notification history" },
			{ "<leader>uC",      function() Snacks.picker.colorschemes() end,          desc = "Colorschemes" },
			-- ── Git ──────────────────────────────────────────────────────────────
			{ "<leader>gg",      function() Snacks.lazygit() end,                      desc = "Lazygit" },
			{ "<leader>gs",      function() Snacks.picker.git_status() end,            desc = "Status (changed files)" },
			{ "<leader>gl",      function() Snacks.picker.git_log() end,               desc = "Log" },
			{ "<leader>gf",      function() Snacks.picker.git_log_file() end,          desc = "Log for this file" },
			{ "<leader>gb",      function() Snacks.picker.git_branches() end,          desc = "Branches" },
			{ "<leader>go",      function() Snacks.gitbrowse() end,                    desc = "Open on GitHub", mode = { "n", "x" } },
			-- ── Buffers / windows ───────────────────────────────────────────────
			{ "<leader>bd",      function() Snacks.bufdelete() end,                    desc = "Close buffer" },
			{ "<A-w>",           function() Snacks.bufdelete() end,                    desc = "Close buffer" },
			{ "<leader>bo",      function() Snacks.bufdelete.other() end,              desc = "Close other buffers" },
			{ "<leader>wm",      function() Snacks.zen.zoom() end,                     desc = "Maximize window (toggle)" },
			-- ── Terminal (VS Code: Ctrl+`) ───────────────────────────────────────
			{ "<C-`>",           function() Snacks.terminal() end,                     desc = "Toggle terminal", mode = { "n", "t" } },
			{ "<C-\\>",          function() Snacks.terminal() end,                     desc = "Toggle terminal", mode = { "n", "t" } },
			-- ── Misc ─────────────────────────────────────────────────────────────
			{ "]]",              function() Snacks.words.jump(vim.v.count1) end,       desc = "Next reference of word" },
			{ "[[",              function() Snacks.words.jump(-vim.v.count1) end,      desc = "Prev reference of word" },
			{ "<leader>un",      function() Snacks.notifier.hide() end,                desc = "Dismiss notifications" },
			{ "<leader>.",       function() Snacks.scratch() end,                      desc = "Scratch buffer" },
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Debug helpers available everywhere: dd(x) / bt()
					_G.dd = function(...) Snacks.debug.inspect(...) end
					_G.bt = function() Snacks.debug.backtrace() end

					-- UI toggles: which-key shows their current on/off state
					local T = Snacks.toggle
					T.option("wrap", { name = "Wrap" }):map("<leader>uw")
					T.option("spell", { name = "Spelling" }):map("<leader>us")
					T.option("relativenumber", { name = "Relative numbers" }):map("<leader>uL")
					T.line_number():map("<leader>ul")
					T.diagnostics():map("<leader>ud")
					T.inlay_hints():map("<leader>uh")
					T.treesitter():map("<leader>uS")
					T.indent():map("<leader>ug")
					T.dim():map("<leader>uD")
					T.zen():map("<leader>uz")
					T.option("conceallevel", { off = 0, on = 2, name = "Conceal" }):map("<leader>uc")
				end,
			})
		end,
	},
}
