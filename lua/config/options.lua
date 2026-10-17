-- Editor options.  :help '<option>' explains any of these, e.g. :help 'scrolloff'

local opt = vim.opt

-- ── UI ──────────────────────────────────────────────────────────────────────
opt.guifont = "Cartograph CF:h13"
opt.number = true
opt.relativenumber = true -- relative numbers make `5j` / `12k` jumps effortless
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.showmode = false -- the statusline shows the mode
opt.cmdheight = 0 -- noice draws the command line as a popup
opt.laststatus = 3 -- one global statusline
opt.winborder = "rounded" -- every floating window gets a rounded border
opt.conceallevel = 2
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.pumheight = 12
opt.pumblend = 0
opt.winblend = 0
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.smoothscroll = true
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.title = true
opt.titlestring = "%<%F%=%l/%L - nvim"
opt.shortmess:append({ c = true, S = true, I = true })
opt.fillchars = {
	horiz = "─",
	horizup = "┴",
	horizdown = "┬",
	vert = "│",
	vertleft = "┤",
	vertright = "├",
	verthoriz = "┼",
	eob = " ",
	diff = "╱",
	fold = " ",
	foldopen = "▾",
	foldclose = "▸",
	foldsep = " ",
}

-- ── Behaviour ───────────────────────────────────────────────────────────────
-- Share the system clipboard (scheduled: the provider lookup is slow at startup).
vim.schedule(function() opt.clipboard = "unnamedplus" end)
opt.mouse = "a"
opt.confirm = true -- ask to save instead of failing on :q
opt.undofile = true
opt.undolevels = 10000
opt.swapfile = false
opt.updatetime = 200
opt.timeoutlen = 400 -- which-key pops up after this delay
opt.virtualedit = "block"
opt.completeopt = "menu,menuone,noselect"
opt.jumpoptions = "view"

-- ── Indentation (per-language overrides live in autocmds.lua / .editorconfig) ─
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftround = true
opt.smartindent = true

-- ── Search ──────────────────────────────────────────────────────────────────
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split" -- live preview for :s/foo/bar
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"

-- ── Folding: treesitter-based, everything open by default ──────────────────
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = "" -- show the folded line with its normal syntax highlighting
opt.foldlevel = 99
opt.foldlevelstart = 99

-- ── Languages ───────────────────────────────────────────────────────────────
vim.g.c_syntax_for_h = true -- treat *.h as C, not C++

-- ── Neovide (GUI) ───────────────────────────────────────────────────────────
if vim.g.neovide then
	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0
	vim.g.neovide_window_blurred = false
end
