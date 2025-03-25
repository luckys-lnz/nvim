-- lua/config/options.lua
-- General Neovim settings

local opt = vim.opt

-- UI
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.cursorline = true -- Highlight current line
opt.signcolumn = "yes" -- Always show the signcolumn
opt.termguicolors = true -- True color support
opt.showmode = false -- Don't show mode since we have a statusline
opt.conceallevel = 2 -- Hide * markup for bold and italic
opt.list = true -- Show some invisible characters
vim.opt.listchars = "tab:» ,trail:·,nbsp:␣"
opt.pumblend = 0 -- Popup blend (0 for fully opaque)
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.scrolloff = 8 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.winblend = 0 -- Window blend (0 for fully opaque)

-- Behavior
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect" -- Better completion experience
opt.confirm = true -- confirm to save changes before exiting
opt.mouse = "a" -- enable mouse mode
opt.undofile = true -- save undo history
opt.undolevels = 10000 -- maximum number of changes that can be undone
opt.updatetime = 200 -- faster completion
opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete
opt.virtualedit = "block" -- allow cursor to move where there is no text in visual block mode
opt.swapfile = false -- don't use swapfile

-- Indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.tabstop = 2 -- Number of spaces tabs count for
opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for
opt.smartindent = true -- Insert indents automatically
opt.wrap = false -- Disable line wrap
opt.breakindent = true -- Enable break indent

-- Search
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals
opt.inccommand = "split" -- Preview substitutions live

-- Windows
opt.title = true -- Set the window title
opt.titlestring = "%<%F%=%l/%L - nvim" -- Format of the window title

-- Folding (using Treesitter)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false -- Disable folding by default
opt.foldlevel = 99

-- Global statusline
opt.laststatus = 3

-- Disable some built-in plugins
local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end
