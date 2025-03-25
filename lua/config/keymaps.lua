-- Keymaps for VS Code-like experience
local keymap = vim.keymap.set

-- Helper function for keymaps
local opts = function(desc)
	return { noremap = true, silent = true, desc = desc }
end

-- Better window navigation (Ctrl + hjkl)
keymap("n", "<C-h>", "<C-w>h", opts("Move to left window"))
keymap("n", "<C-j>", "<C-w>j", opts("Move to bottom window"))
keymap("n", "<C-k>", "<C-w>k", opts("Move to top window"))
keymap("n", "<C-l>", "<C-w>l", opts("Move to right window"))

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts("Resize window up"))
keymap("n", "<C-Down>", ":resize +2<CR>", opts("Resize window down"))
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts("Resize window left"))
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts("Resize window right"))

-- Navigate buffers (Tab/Shift+Tab)
keymap("n", "<Tab>", ":bnext<CR>", opts("Next buffer"))
keymap("n", "<S-Tab>", ":bprevious<CR>", opts("Previous buffer"))

-- Close buffer
keymap("n", "<leader>x", ":bd<CR>", opts("Close buffer"))
keymap("n", "<leader>X", ":bd!<CR>", opts("Force close buffer"))

-- Save file (Ctrl+S)
keymap("n", "<C-s>", ":w<CR>", opts("Save file"))
keymap("i", "<C-s>", "<Esc>:w<CR>", opts("Save file"))

-- Quit
keymap("n", "<leader>q", ":q<CR>", opts("Quit"))
keymap("n", "<leader>Q", ":qa!<CR>", opts("Force quit"))

-- Select all (Ctrl+A)
keymap("n", "<C-a>", "gg<S-v>G", opts("Select all"))

-- Stay in indent mode when indenting
keymap("v", "<", "<gv", opts("Indent left"))
keymap("v", ">", ">gv", opts("Indent right"))

-- Move text up and down (Alt+j/k)
keymap("n", "<A-j>", ":m .+1<CR>==", opts("Move line down"))
keymap("n", "<A-k>", ":m .-2<CR>==", opts("Move line up"))
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts("Move selection down"))
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts("Move selection up"))

-- Keep cursor centered when scrollingS
keymap("n", "<C-U>", "<C-d>zz", opts("Scroll down and center"))
keymap("n", "<C-u>", "<C-u>zz", opts("Scroll up and center"))

-- Keep cursor centered when searching
keymap("n", "n", "nzzzv", opts("Next search result and center"))
keymap("n", "N", "Nzzzv", opts("Previous search result and center"))

-- Clear search highlights
keymap("n", "<leader>h", ":nohlsearch<CR>", opts("Clear highlights"))

-- Better paste (don't copy replaced text)
keymap("v", "p", '"_dP', opts("Paste without copying"))

-- Delete without copying
keymap("n", "<leader>d", '"_d', opts("Delete without copying"))
keymap("v", "<leader>d", '"_d', opts("Delete without copying"))

-- Yank to system clipboard
keymap("n", "<leader>y", '"+y', opts("Yank to system clipboard"))
keymap("v", "<leader>y", '"+y', opts("Yank to system clipboard"))
keymap("n", "<leader>Y", '"+Y', opts("Yank line to system clipboard"))

-- VS Code-like split editor
keymap("n", "<leader>\\", ":vsplit<CR>", opts("Split vertically"))
keymap("n", "<leader>-", ":split<CR>", opts("Split horizontally"))

-- VS Code-like toggle sidebar
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts("Toggle file explorer"))

-- VS Code-like rename
keymap("n", "<F2>", ":lua vim.lsp.buf.rename()<CR>", opts("Rename symbol"))

-- VS Code-like outline
keymap("n", "<leader>o", ":Outline<CR>", opts("Toggle outline"))

-- VS Code-like symbols
keymap("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", opts("Document symbols"))
keymap("n", "<leader>fS", ":Telescope lsp_workspace_symbols<CR>", opts("Workspace symbols"))

-- VS Code-like quick open recent
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", opts("Recent files"))

-- VS Code-like problems
keymap("n", "<leader>xx", ":TroubleToggle<CR>", opts("Toggle trouble"))
keymap("n", "<leader>xw", ":TroubleToggle workspace_diagnostics<CR>", opts("Workspace diagnostics"))
keymap("n", "<leader>xd", ":TroubleToggle document_diagnostics<CR>", opts("Document diagnostics"))
keymap("n", "<leader>xq", ":TroubleToggle quickfix<CR>", opts("Quickfix"))
keymap("n", "<leader>xl", ":TroubleToggle loclist<CR>", opts("Location list"))

-- VS Code-like debug
keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", opts("Continue debugging"))
keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts("Step over"))
keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts("Step into"))
keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>", opts("Step out"))
keymap("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", opts("Toggle breakpoint"))
keymap(
	"n",
	"<leader>dB",
	":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	opts("Set conditional breakpoint")
)
keymap(
	"n",
	"<leader>dl",
	":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
	opts("Set log point")
)
keymap("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", opts("Open REPL"))
keymap("n", "<leader>dt", ":lua require'dap'.terminate()<CR>", opts("Terminate debug session"))

-- VS Code-like lazygit
keymap("n", "<leader>gg", ":LazyGit<CR>", opts("Open LazyGit"))

-- VS Code-like notifications
keymap("n", "<leader>un", ":Notifications<CR>", opts("Show notifications"))
