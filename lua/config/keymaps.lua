-- Keymaps for VS Code-like experience
local keymap = vim.keymap.set

-- Helper function for keymaps
local opts = function(desc)
	return { noremap = true, silent = true, desc = desc }
end

-- Window Navigation (Ctrl + hjkl)
keymap("n", "<C-h>", "<C-w>h", opts("Move to left window"))
keymap("n", "<C-j>", "<C-w>j", opts("Move to bottom window"))
keymap("n", "<C-k>", "<C-w>k", opts("Move to top window"))
keymap("n", "<C-l>", "<C-w>l", opts("Move to right window"))

-- Resize Windows (Ctrl + Arrow keys)
keymap("n", "<C-Up>", ":resize -2<CR>", opts("Resize window up"))
keymap("n", "<C-Down>", ":resize +2<CR>", opts("Resize window down"))
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts("Resize window left"))
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts("Resize window right"))

-- Keymaps for VS Code-like experience
local keymap = vim.keymap.set

-- Helper function for keymaps
local opts = function(desc)
	return { noremap = true, silent = true, desc = desc }
end

-- Window Navigation (Ctrl + hjkl)
keymap("n", "<C-h>", "<C-w>h", opts("Move to left window"))
keymap("n", "<C-j>", "<C-w>j", opts("Move to bottom window"))
keymap("n", "<C-k>", "<C-w>k", opts("Move to top window"))
keymap("n", "<C-l>", "<C-w>l", opts("Move to right window"))

-- Resize Windows (Ctrl + Arrow keys)
keymap("n", "<C-Up>", ":resize -2<CR>", opts("Resize window up"))
keymap("n", "<C-Down>", ":resize +2<CR>", opts("Resize window down"))
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts("Resize window left"))
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts("Resize window right"))

-- Buffer Navigation
keymap("n", "<Tab>", ":bnext<CR>", opts("Next buffer"))
keymap("n", "<S-Tab>", ":bprevious<CR>", opts("Previous buffer"))
keymap("n", "<leader>xb", ":bd<CR>", opts("Close buffer"))

-- File Operations
keymap("n", "<C-s>", ":w<CR>", opts("Save file"))
keymap("i", "<C-s>", "<Esc>:w<CR>", opts("Save file"))

-- Quit
keymap("n", "<leader>qq", ":q<CR>", opts("Quit"))
keymap("n", "<leader>Qq", ":qa!<CR>", opts("Force quit"))

-- Select All
keymap("n", "<C-a>", "gg<S-v>G", opts("Select all"))

-- Indentation
keymap("v", "<", "<gv", opts("Indent left"))
keymap("v", ">", ">gv", opts("Indent right"))

-- Move Lines (Alt+j/k)
keymap("n", "<A-j>", ":m .+1<CR>==", opts("Move line down"))
keymap("n", "<A-k>", ":m .-2<CR>==", opts("Move line up"))
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts("Move selection down"))
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts("Move selection up"))

-- Center Cursor When Scrolling & Searching
keymap("n", "<C-d>", "<C-d>zz", opts("Scroll down and center"))
keymap("n", "<C-u>", "<C-u>zz", opts("Scroll up and center"))
keymap("n", "n", "nzzzv", opts("Next search result and center"))
keymap("n", "N", "Nzzzv", opts("Previous search result and center"))

-- Clear Search Highlights
keymap("n", "<leader>hh", ":nohlsearch<CR>", opts("Clear highlights"))

-- Paste Without Overwriting Register
keymap("v", "p", '"_dP', opts("Paste without copying"))

-- Delete Without Copying
keymap("n", "<leader>dd", '"_d', opts("Delete without copying"))
keymap("v", "<leader>dd", '"_d', opts("Delete without copying"))

-- Yank to System Clipboard
keymap("n", "<leader>yy", '"+y', opts("Yank to system clipboard"))
keymap("v", "<leader>yy", '"+y', opts("Yank to system clipboard"))
keymap("n", "<leader>YY", '"+Y', opts("Yank line to system clipboard"))

-- Splits
keymap("n", "<leader>\\", ":vsplit<CR>", opts("Split vertically"))
keymap("n", "<leader>-", ":split<CR>", opts("Split horizontally"))

-- File Explorer
keymap("n", "<leader>ee", ":NvimTreeToggle<CR>", opts("Toggle file explorer"))

-- LSP Features
keymap("n", "<F2>", ":lua vim.lsp.buf.rename()<CR>", opts("Rename symbol"))
keymap("n", "<leader>oo", ":Outline<CR>", opts("Toggle outline"))

-- Symbols
keymap("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", opts("Document symbols"))
keymap("n", "<leader>fS", ":Telescope lsp_workspace_symbols<CR>", opts("Workspace symbols"))

-- Recent Files
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", opts("Recent files"))
