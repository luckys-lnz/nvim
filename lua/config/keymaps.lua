-- Core keymaps (no plugins needed).  Plugin keys live next to their plugin spec.
-- Every mapping has a `desc`: that is what which-key and <Space>sk display.
--
-- Golden rules kept on purpose:
--   * `d`, `c`, `x` still cut into the register — `dd` + `p` moves a line.
--   * <C-w>, <C-d>, <C-u>, <C-o>, <C-i> keep their Vim meaning.

local map = vim.keymap.set

-- ── VS Code muscle memory ───────────────────────────────────────────────────
map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>write<cr><esc>", { desc = "Save file" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
map("x", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })
map("n", "<C-_>", "gcc", { remap = true, desc = "which_key_ignore" }) -- terminals send Ctrl+/ as <C-_>
map("x", "<C-_>", "gc", { remap = true, desc = "which_key_ignore" })

-- Move lines: Alt+j/k (Vim style) or Alt+↑/↓ (VS Code style)
for _, k in ipairs({ { "<A-j>", "<A-k>" }, { "<A-Down>", "<A-Up>" } }) do
	local down, up = k[1], k[2]
	map("n", down, "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move line down" })
	map("n", up, "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move line up" })
	map("i", down, "<esc><cmd>move .+1<cr>==gi", { desc = "Move line down" })
	map("i", up, "<esc><cmd>move .-2<cr>==gi", { desc = "Move line up" })
	map(
		"x",
		down,
		":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv",
		{ silent = true, desc = "Move selection down" }
	)
	map(
		"x",
		up,
		":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv",
		{ silent = true, desc = "Move selection up" }
	)
end

-- ── Windows ─────────────────────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
map("n", "<leader>wv", "<C-w>v", { desc = "Split right" })
map("n", "<leader>ws", "<C-w>s", { desc = "Split below" })
map("n", "<leader>wc", "<C-w>c", { desc = "Close window" })
map("n", "<leader>wo", "<C-w>o", { desc = "Close other windows" })
map("n", "<leader>w=", "<C-w>=", { desc = "Equalize sizes" })
map("n", "<leader>|", "<C-w>v", { desc = "Split right" })
map("n", "<leader>-", "<C-w>s", { desc = "Split below" })

-- ── Buffers (tabs in VS Code terms) ─────────────────────────────────────────
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New empty buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to last buffer" })

-- ── Editing comfort ─────────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<cr><esc>", { desc = "Clear search highlight" })
map("x", "<", "<gv", { desc = "Indent left (keep selection)" })
map("x", ">", ">gv", { desc = "Indent right (keep selection)" })
map("x", "p", "P", { desc = "Paste without overwriting the register" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "Next search result (centered)" })
map("n", "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "Prev search result (centered)" })
map("i", ",", ",<C-g>u") -- undo break-points: `u` undoes one phrase, not a whole paragraph
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")

-- Treesitter incremental selection (built into Neovim 0.12 as `an` / `in`)
map("n", "<C-Space>", "van", { remap = true, desc = "Start/expand selection" })
map("x", "<C-Space>", "an", { remap = true, desc = "Expand selection" })
map("x", "<BS>", "in", { remap = true, desc = "Shrink selection" })

-- ── Diagnostics (]d / [d are built in) ──────────────────────────────────────
local function jump(count, severity)
	return function()
		vim.diagnostic.jump({ count = count, float = true, severity = severity and vim.diagnostic.severity[severity] })
	end
end
map("n", "]e", jump(1, "ERROR"), { desc = "Next error" })
map("n", "[e", jump(-1, "ERROR"), { desc = "Prev error" })
map("n", "]w", jump(1, "WARN"), { desc = "Next warning" })
map("n", "[w", jump(-1, "WARN"), { desc = "Prev warning" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- ── Run the current file (VS Code "Run Python File" / Code Runner) ─────────
map("n", "<leader>rr", function() require("util.run").file() end, { desc = "Run current file" })
map("n", "<leader>rs", function() require("util.run").npm_script() end, { desc = "Run package.json script" })

-- ── Terminal mode ───────────────────────────────────────────────────────────
-- Double <Esc> leaves terminal mode; a single <Esc> still reaches the program
-- (so vim/lazygit/fzf running inside the terminal keep working).
map("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Go to left window" })
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Go to lower window" })
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Go to upper window" })
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Go to right window" })

-- ── Quit / tools ────────────────────────────────────────────────────────────
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Plugins (Lazy)" })
map("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Tools (Mason)" })
map("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", { desc = "LSP info" })
map("n", "<leader>?", function() require("guru").open() end, { desc = "Guru: VS Code → Neovim cheatsheet" })
