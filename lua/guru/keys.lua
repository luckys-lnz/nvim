-- The VS Code → Neovim cheatsheet.  Single source of truth for:
--   * <Space>?   searchable picker (type a VS Code shortcut, an intent, or a key)
--   * statusline / dashboard tips
--   * scripts/check-keys.lua, which fails if a key listed here is not mapped
--
-- Fields: cat · vscode (what you'd press in VS Code, or "") · keys · desc
--         mode (default "n") · kind: "map" (ours), "builtin" (Vim/Neovim), "lsp" (needs a server),
--         "buffer" (needs a git-tracked file) · ft (only mapped for that filetype)
--         tip (optional longer explanation shown in the preview)

local M = {}

-- stylua: ignore
M.list = {
	-- ── Files & navigation ────────────────────────────────────────────────────
	{ cat = "Files", vscode = "Ctrl+P",         keys = "<C-p>",           desc = "Quick-open a file" },
	{ cat = "Files", vscode = "Ctrl+P",         keys = "<leader><space>", desc = "Smart open: buffers + recent + files" },
	{ cat = "Files", vscode = "Ctrl+R",         keys = "<leader>fr",      desc = "Recent files" },
	{ cat = "Files", vscode = "Ctrl+Tab",       keys = "<leader>,",       desc = "Switch between open buffers" },
	{ cat = "Files", vscode = "Ctrl+Shift+E",   keys = "<leader>e",       desc = "Toggle file explorer", tip = "In the tree: a add · d delete · r rename · c copy · m move · ? help" },
	{ cat = "Files", vscode = "Reveal in Explorer", keys = "<leader>E",   desc = "Reveal current file in explorer" },
	{ cat = "Files", vscode = "Ctrl+S",         keys = "<C-s>",           desc = "Save file", tip = "The Vim way is :w<Enter>. :wa saves all, :x saves & closes." },
	{ cat = "Files", vscode = "Ctrl+N",         keys = "<leader>bn",      desc = "New empty buffer" },
	{ cat = "Files", vscode = "",               keys = "<leader>fc",      desc = "Open a file from this config" },
	{ cat = "Files", vscode = "Rename file",     keys = "<leader>cR",     desc = "Rename file and update imports", kind = "lsp" },

	-- ── Tabs / buffers / windows ──────────────────────────────────────────────
	{ cat = "Tabs", vscode = "Ctrl+PgUp/PgDn",  keys = "<S-h>",           desc = "Previous tab (buffer)" },
	{ cat = "Tabs", vscode = "Ctrl+PgDn",       keys = "<S-l>",           desc = "Next tab (buffer)" },
	{ cat = "Tabs", vscode = "Alt+1-9",         keys = "<A-1>",           desc = "Go to tab 1-9 (Alt+number)" },
	{ cat = "Tabs", vscode = "Ctrl+W",          keys = "<leader>bd",      desc = "Close tab (buffer)", tip = "Alt+w also closes. <Space>bo closes all others." },
	{ cat = "Tabs", vscode = "Close Others",    keys = "<leader>bo",      desc = "Close all other tabs" },
	{ cat = "Tabs", vscode = "Pin tab",         keys = "<leader>bp",      desc = "Pin tab" },
	{ cat = "Tabs", vscode = "",                keys = "<leader>`",       desc = "Jump to the previous buffer (toggle)" },
	{ cat = "Windows", vscode = "Ctrl+\\",      keys = "<leader>|",       desc = "Split editor right" },
	{ cat = "Windows", vscode = "",             keys = "<leader>-",       desc = "Split editor down" },
	{ cat = "Windows", vscode = "Ctrl+1/2/3",   keys = "<C-h>",           desc = "Focus window left (C-j/k/l for others)" },
	{ cat = "Windows", vscode = "",             keys = "<leader>wc",      desc = "Close window" },
	{ cat = "Windows", vscode = "Maximize group", keys = "<leader>wm",    desc = "Zoom window (toggle)" },
	{ cat = "Windows", vscode = "",             keys = "<C-Left>",        desc = "Resize window (Ctrl+arrows)" },

	-- ── Search ────────────────────────────────────────────────────────────────
	{ cat = "Search", vscode = "Ctrl+Shift+F",  keys = "<leader>/",       desc = "Search text in project" },
	{ cat = "Search", vscode = "",              keys = "<leader>sw",      desc = "Search word under cursor in project" },
	{ cat = "Search", vscode = "Ctrl+F",        keys = "/",               desc = "Find in file (n / N = next / prev)", kind = "builtin" },
	{ cat = "Search", vscode = "Ctrl+H",        keys = ":%s/old/new/g",   desc = "Replace in file (add c at end to confirm each)", kind = "builtin" },
	{ cat = "Search", vscode = "",              keys = "*",               desc = "Search word under cursor in file", kind = "builtin" },
	{ cat = "Search", vscode = "Ctrl+Shift+P",  keys = "<C-S-p>",         desc = "Command palette", tip = "If your terminal can't send Ctrl+Shift+P use <Space>sc." },
	{ cat = "Search", vscode = "Ctrl+Shift+P",  keys = "<leader>sc",      desc = "Command palette" },
	{ cat = "Search", vscode = "Ctrl+K Ctrl+S", keys = "<leader>sk",      desc = "Search ALL keymaps" },
	{ cat = "Search", vscode = "",              keys = "<leader>sh",      desc = "Search help pages" },
	{ cat = "Search", vscode = "",              keys = "<leader>sr",      desc = "Resume last search" },
	{ cat = "Search", vscode = "Ctrl+Shift+O",  keys = "<leader>ss",      desc = "Go to symbol in file" },
	{ cat = "Search", vscode = "Ctrl+T",        keys = "<leader>sS",      desc = "Go to symbol in workspace" },
	{ cat = "Search", vscode = "Timeline",      keys = "<leader>su",      desc = "Undo history (time travel)" },

	-- ── Editing ───────────────────────────────────────────────────────────────
	{ cat = "Edit", vscode = "Ctrl+/",          keys = "<C-/>",           desc = "Toggle comment", tip = "Vim way: gcc (line) · gc{motion} e.g. gcip = comment paragraph" },
	{ cat = "Edit", vscode = "Ctrl+/",          keys = "gcc",             desc = "Comment line (gc + motion for more)", kind = "builtin" },
	{ cat = "Edit", vscode = "Alt+↑/↓",         keys = "<A-j>",           desc = "Move line down (Alt+k up, or Alt+arrows)" },
	{ cat = "Edit", vscode = "Shift+Alt+↓",     keys = "yyp",             desc = "Duplicate line", kind = "builtin" },
	{ cat = "Edit", vscode = "Ctrl+Shift+K",    keys = "dd",              desc = "Delete (cut) line", kind = "builtin" },
	{ cat = "Edit", vscode = "Ctrl+X / Ctrl+C", keys = "dd / yy",         desc = "Cut / copy line — p pastes below", kind = "builtin" },
	{ cat = "Edit", vscode = "Ctrl+Z / Ctrl+Y", keys = "u / <C-r>",       desc = "Undo / redo", kind = "builtin" },
	{ cat = "Edit", vscode = "Ctrl+A",          keys = "<C-a>",           desc = "Select all" },
	{ cat = "Edit", vscode = "Ctrl+]",          keys = ">>",              desc = "Indent line (<< outdent; > / < in visual)", kind = "builtin" },
	{ cat = "Edit", vscode = "Ctrl+D",          keys = "<M-n>",           desc = "Multi-cursor: add next match", tip = "Then type to edit all. <M-x> skip · <M-p> remove · Esc exit" },
	{ cat = "Edit", vscode = "Ctrl+Shift+L",    keys = "<M-a>",           desc = "Multi-cursor: select all matches" },
	{ cat = "Edit", vscode = "Ctrl+Alt+↓",      keys = "<C-M-j>",         desc = "Multi-cursor: add cursor below" },
	{ cat = "Edit", vscode = "Expand selection",keys = "<C-Space>",       desc = "Expand selection by syntax (BS shrinks)" },
	{ cat = "Edit", vscode = "",                keys = "ysiw\"",          desc = "Surround word with quotes", kind = "builtin", tip = "ys{motion}{char} add · ds\" delete · cs\"' change \" to '" },
	{ cat = "Edit", vscode = "",                keys = "<leader>cs",      desc = "Swap function argument with next" },

	-- ── Code intelligence (needs a language server) ──────────────────────────
	{ cat = "Code", vscode = "F12",             keys = "gd",              desc = "Go to definition", kind = "lsp", tip = "Ctrl+o jumps back, Ctrl+i forward — like Alt+← / Alt+→" },
	{ cat = "Code", vscode = "Alt+F12",         keys = "gpd",             desc = "Peek definition" },
	{ cat = "Code", vscode = "Shift+F12",       keys = "grr",             desc = "Find all references", kind = "lsp" },
	{ cat = "Code", vscode = "Ctrl+F12",        keys = "gri",             desc = "Go to implementation", kind = "lsp" },
	{ cat = "Code", vscode = "",                keys = "grt",             desc = "Go to type definition", kind = "lsp" },
	{ cat = "Code", vscode = "Hover",           keys = "K",               desc = "Hover docs (press K again to enter)", kind = "builtin" },
	{ cat = "Code", vscode = "Ctrl+Shift+Space",keys = "gK",              desc = "Signature help (Ctrl+k in insert)", kind = "lsp" },
	{ cat = "Code", vscode = "F2",              keys = "<F2>",            desc = "Rename symbol (live preview)", kind = "lsp", tip = "Built-in alternative: grn" },
	{ cat = "Code", vscode = "Ctrl+.",          keys = "<leader>ca",      desc = "Code action / quick fix", kind = "lsp", tip = "Also gra (built-in) or Ctrl+. if your terminal sends it" },
	{ cat = "Code", vscode = "Organize Imports",keys = "<leader>co",      desc = "Organize imports", kind = "lsp" },
	{ cat = "Code", vscode = "Shift+Alt+F",     keys = "<leader>cf",      desc = "Format file (also runs on save)" },
	{ cat = "Code", vscode = "Ctrl+Space",      keys = "<C-Space>",       desc = "Trigger completion (insert mode)", mode = "i", kind = "builtin" },
	{ cat = "Code", vscode = "Tab",             keys = "<Tab>",           desc = "Accept completion / Copilot suggestion", mode = "i", kind = "builtin" },
	{ cat = "Code", vscode = "Breadcrumbs",     keys = "<leader>;",       desc = "Pick a symbol from the breadcrumbs" },
	{ cat = "Code", vscode = "Outline",         keys = "<leader>xs",      desc = "Symbol outline panel" },
	{ cat = "Code", vscode = "",                keys = "<leader>uh",      desc = "Toggle inlay type hints" },

	-- ── Problems ─────────────────────────────────────────────────────────────
	{ cat = "Problems", vscode = "Ctrl+Shift+M",keys = "<leader>xx",      desc = "Problems panel (workspace)" },
	{ cat = "Problems", vscode = "",            keys = "<leader>xX",      desc = "Problems in this file" },
	{ cat = "Problems", vscode = "F8",          keys = "]d",              desc = "Next problem ([d prev, ]e errors only)", kind = "builtin" },
	{ cat = "Problems", vscode = "",            keys = "<leader>cd",      desc = "Show the problem on this line" },
	{ cat = "Problems", vscode = "",            keys = "]t",              desc = "Next TODO/FIX comment" },

	-- ── Language specials ─────────────────────────────────────────────────────
	{ cat = "Python", vscode = "Select Interpreter", keys = "<leader>cv", desc = "Select virtualenv", kind = "lsp", ft = "python", plugin = "venv-selector.nvim" },
	{ cat = "Python", vscode = "Run Python File", keys = "<leader>rr",    desc = "Run current file in a terminal" },
	{ cat = "C",      vscode = "Alt+O",           keys = "<leader>ch",    desc = "Switch header ⇄ source", kind = "lsp", ft = "c" },
	{ cat = "C",      vscode = "Run Code",        keys = "<leader>rr",    desc = "Compile with cc -Wall and run" },
	{ cat = "Web",    vscode = "npm scripts",     keys = "<leader>rs",    desc = "Run a package.json script (dev, build…)" },
	{ cat = "Web",    vscode = "Add missing imports", keys = "<leader>cM", desc = "Add all missing imports (TS)", kind = "lsp", ft = "typescriptreact" },
	{ cat = "Web",    vscode = "",                keys = "<leader>cu",    desc = "Remove unused imports (TS)", kind = "lsp", ft = "typescriptreact" },
	{ cat = "Web",    vscode = "Emmet",           keys = "div.card>p*3",  desc = "Type an Emmet abbreviation, pick it from completion", kind = "builtin" },

	-- ── Run & debug ───────────────────────────────────────────────────────────
	{ cat = "Debug", vscode = "F5",             keys = "<F5>",            desc = "Start / continue debugging" },
	{ cat = "Debug", vscode = "F9",             keys = "<F9>",            desc = "Toggle breakpoint" },
	{ cat = "Debug", vscode = "F10",            keys = "<F10>",           desc = "Step over" },
	{ cat = "Debug", vscode = "F11",            keys = "<F11>",           desc = "Step into (Shift+F11 out)" },
	{ cat = "Debug", vscode = "Shift+F5",       keys = "<leader>dt",      desc = "Stop debugging" },
	{ cat = "Debug", vscode = "",               keys = "<leader>dB",      desc = "Conditional breakpoint" },
	{ cat = "Debug", vscode = "",               keys = "<leader>du",      desc = "Debugger UI (toggle)" },
	{ cat = "Debug", vscode = "Debug Console",  keys = "<leader>dr",      desc = "Debug REPL" },
	{ cat = "Test",  vscode = "Run Test",       keys = "<leader>tt",      desc = "Run nearest test" },
	{ cat = "Test",  vscode = "",               keys = "<leader>tf",      desc = "Run tests in this file" },
	{ cat = "Test",  vscode = "Debug Test",     keys = "<leader>td",      desc = "Debug nearest test" },
	{ cat = "Test",  vscode = "Testing panel",  keys = "<leader>ts",      desc = "Test explorer" },

	-- ── Git ───────────────────────────────────────────────────────────────────
	{ cat = "Git", vscode = "Ctrl+Shift+G",     keys = "<leader>gg",      desc = "Lazygit (full git UI)", tip = "Needs the lazygit binary. <Space>gs is a built-in alternative." },
	{ cat = "Git", vscode = "Source Control",   keys = "<leader>gs",      desc = "Changed files" },
	{ cat = "Git", vscode = "",                 keys = "]h",              desc = "Next change in file ([h prev)", kind = "buffer" },
	{ cat = "Git", vscode = "Stage Change",     keys = "<leader>hs",      desc = "Stage hunk under cursor", kind = "buffer" },
	{ cat = "Git", vscode = "Revert Change",    keys = "<leader>hr",      desc = "Discard hunk under cursor", kind = "buffer" },
	{ cat = "Git", vscode = "",                 keys = "<leader>hp",      desc = "Preview hunk inline", kind = "buffer" },
	{ cat = "Git", vscode = "GitLens blame",    keys = "<leader>ub",      desc = "Toggle inline blame", kind = "buffer" },
	{ cat = "Git", vscode = "Open Changes",     keys = "<leader>gd",      desc = "Diff view of working tree" },
	{ cat = "Git", vscode = "Timeline",         keys = "<leader>gh",      desc = "File history" },

	-- ── Terminal, AI, UI ──────────────────────────────────────────────────────
	{ cat = "Terminal", vscode = "Ctrl+`",      keys = "<C-\\>",          desc = "Toggle terminal (Ctrl+` too)", tip = "Esc Esc leaves terminal mode so you can scroll/copy" },
	{ cat = "AI", vscode = "Ctrl+Alt+I",        keys = "<leader>aa",      desc = "Copilot Chat (toggle) — also F8" },
	{ cat = "AI", vscode = "/explain",          keys = "<leader>ae",      desc = "Explain selected code", mode = "x" },
	{ cat = "AI", vscode = "/fix",              keys = "<leader>af",      desc = "Fix selected code", mode = "x" },
	{ cat = "AI", vscode = "Accept suggestion", keys = "<M-l>",           desc = "Accept Copilot ghost text (or Tab)", mode = "i", kind = "builtin" },
	{ cat = "UI", vscode = "Zen Mode",          keys = "<leader>uz",      desc = "Zen mode" },
	{ cat = "UI", vscode = "Color Theme",       keys = "<leader>uT",      desc = "Toggle dark / light theme" },
	{ cat = "UI", vscode = "Word Wrap (Alt+Z)", keys = "<leader>uw",      desc = "Toggle word wrap" },
	{ cat = "UI", vscode = "",                  keys = "<leader>uf",      desc = "Toggle format on save" },
	{ cat = "UI", vscode = "",                  keys = "<leader>uH",      desc = "Hardtime: motion-training mode" },
	{ cat = "Session", vscode = "Reopen folder",keys = "<leader>qs",      desc = "Restore session for this folder" },
	{ cat = "Session", vscode = "Quit",         keys = "<leader>qq",      desc = "Quit all (asks to save)" },

	-- ── Vim superpowers (no VS Code equivalent — learn these!) ───────────────
	{ cat = "Vim", vscode = "", keys = "ciw",       desc = "Change inner word (diw delete, yiw copy)", kind = "builtin", tip = "verb + object: c/d/y + iw/i\"/i(/ip/af/ic … works everywhere" },
	{ cat = "Vim", vscode = "", keys = "ci\"",      desc = "Change text inside quotes (works for ( [ { ' ` too)", kind = "builtin" },
	{ cat = "Vim", vscode = "", keys = "daf",       desc = "Delete a whole function (treesitter object)", kind = "builtin", tip = "af/if function · ac/ic class · aa/ia argument · ai/ii if · al/il loop" },
	{ cat = "Vim", vscode = "", keys = ".",         desc = "Repeat the last change", kind = "builtin" },
	{ cat = "Vim", vscode = "", keys = "s",         desc = "Flash: jump anywhere with 2 chars + label" },
	{ cat = "Vim", vscode = "", keys = "f{char}",   desc = "Jump to next {char} on line (; repeats, t stops before)", kind = "builtin" },
	{ cat = "Vim", vscode = "", keys = "%",         desc = "Jump to matching bracket", kind = "builtin" },
	{ cat = "Vim", vscode = "", keys = "]f",        desc = "Next function ([f prev, ]o class, ]a argument)" },
	{ cat = "Vim", vscode = "", keys = "<C-o>",     desc = "Jump back (Ctrl+i forward)", kind = "builtin" },
	{ cat = "Vim", vscode = "", keys = "qa … q",    desc = "Record macro into a, @a plays it, @@ repeats", kind = "builtin" },
	{ cat = "Vim", vscode = "", keys = "zz",        desc = "Centre the screen on the cursor (zt top, zb bottom)", kind = "builtin" },
	{ cat = "Vim", vscode = "", keys = "za",        desc = "Toggle fold (zR open all, zM close all)", kind = "builtin" },
	{ cat = "Vim", vscode = "", keys = "gv",        desc = "Reselect last selection", kind = "builtin" },
	{ cat = "Vim", vscode = "", keys = "<C-v>",     desc = "Block (column) selection — I or A to insert on every line", kind = "builtin" },
	{ cat = "Vim", vscode = "", keys = "<leader>?", desc = "Open this cheatsheet" },
}

return M
