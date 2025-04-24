-- Keymaps configuration
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

-- Resize Windows (Alt + hjkl) - More ergonomic than Ctrl + Arrow keys
keymap("n", "<A-h>", ":vertical resize -2<CR>", opts("Resize window left"))
keymap("n", "<A-j>", ":resize +2<CR>", opts("Resize window down"))
keymap("n", "<A-k>", ":resize -2<CR>", opts("Resize window up"))
keymap("n", "<A-l>", ":vertical resize +2<CR>", opts("Resize window right"))

-- Buffer Navigation
-- Note: Buffer navigation is handled by bufferline plugin with <S-h>, <S-l>, [b, ]b
-- Removing redundant Tab and S-Tab mappings

-- Quit
keymap("n", "<leader>q", ":q<CR>", opts("Quit"))
keymap("n", "<leader>Q", ":qa!<CR>", opts("Force quit"))

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
keymap("n", "<leader>h", ":nohlsearch<CR>", opts("Clear highlights"))

-- Paste Without Overwriting Register
keymap("v", "p", '"_dP', opts("Paste without copying"))

-- Delete Without Copying
keymap("n", "d", '"_d', opts("Delete without copying"))
keymap("v", "d", '"_d', opts("Delete without copying"))

-- Yank to System Clipboard
keymap("n", "y", '"+y', opts("Yank to system clipboard"))
keymap("v", "y", '"+y', opts("Yank to system clipboard"))
keymap("n", "Y", '"+Y', opts("Yank line to system clipboard"))

-- Splits
keymap("n", "<leader>\\", ":vsplit<CR>", opts("Split vertically"))
keymap("n", "<leader>-", ":split<CR>", opts("Split horizontally"))

-- Note: File Explorer keymap is handled by neo-tree plugin with <leader>e and <C-n>
-- Removing redundant keymap

-- Note: LSP Features are handled by lsp/keymaps.lua
-- Removing redundant keymaps

-- Note: Telescope Features are handled by telescope.lua
-- Removing redundant keymaps
