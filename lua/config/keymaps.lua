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
keymap("n", "<leader>x", ":bd<CR>", opts("Close buffer"))
keymap("n", "<leader>X", ":bd!<CR>", opts("Force close buffer"))

-- File Operations
keymap("n", "<C-s>", ":w<CR>", opts("Save file"))
keymap("i", "<C-s>", "<Esc>:w<CR>", opts("Save file"))

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
keymap("n", "<leader>d", '"_d', opts("Delete without copying"))
keymap("v", "<leader>d", '"_d', opts("Delete without copying"))

-- Yank to System Clipboard
keymap("n", "<leader>y", '"+y', opts("Yank to system clipboard"))
keymap("v", "<leader>y", '"+y', opts("Yank to system clipboard"))
keymap("n", "<leader>Y", '"+Y', opts("Yank line to system clipboard"))

-- Splits
keymap("n", "<leader>\\", ":vsplit<CR>", opts("Split vertically"))
keymap("n", "<leader>-", ":split<CR>", opts("Split horizontally"))

-- File Explorer
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts("Toggle file explorer"))

-- LSP Features
keymap("n", "<F2>", ":lua vim.lsp.buf.rename()<CR>", opts("Rename symbol"))
keymap("n", "<leader>o", ":Outline<CR>", opts("Toggle outline"))

-- Symbols
keymap("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", opts("Document symbols"))
keymap("n", "<leader>fS", ":Telescope lsp_workspace_symbols<CR>", opts("Workspace symbols"))

-- Recent Files
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", opts("Recent files"))

-- Diagnostics (Trouble.nvim)
keymap("n", "<leader>tt", ":TroubleToggle<CR>", opts("Toggle Trouble panel"))
keymap("n", "<leader>tdl", ":TroubleToggle document_diagnostics<CR>", opts("Document diagnostics"))
keymap("n", "<leader>twl", ":TroubleToggle workspace_diagnostics<CR>", opts("Workspace diagnostics"))
keymap("n", "<leader>tll", ":TroubleToggle loclist<CR>", opts("Location list"))
keymap("n", "<leader>tql", ":TroubleToggle quickfix<CR>", opts("Quickfix list"))

-- Trouble Navigation
keymap("n", "[t", function()
	if require("trouble").is_open() then
		require("trouble").previous({ skip_groups = true, jump = true })
	else
		local ok, err = pcall(vim.cmd.cprev)
		if not ok then
			vim.notify(err, vim.log.levels.ERROR)
		end
	end
end, opts("Previous trouble item"))

keymap("n", "]t", function()
	local trouble = require("trouble")
	if trouble.is_open() then
		local current_node = trouble.view:get_selected() or {}
		trouble.next({ skip_groups = true, jump = true }, { item = {}, node = current_node, opts = {} })
	else
		local ok, err = pcall(vim.cmd.cnext)
		if not ok then
			vim.notify(err, vim.log.levels.ERROR)
		end
	end
end, opts("Next trouble item"))

-- Debugging (DAP)
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

-- Git
keymap("n", "<leader>gg", ":LazyGit<CR>", opts("Open LazyGit"))

-- Notifications
keymap("n", "<leader>un", ":Notifications<CR>", opts("Show notifications"))
