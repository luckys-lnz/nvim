""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Welcome to my grubox vim world, while this config has not met my taste yet.
" DESCRIPTION: LUCKYS-LNZ VIM CONFIGURATION - GRUVBOX COLOR SCHEME AS MAIN
"              SKIN
" AUTHOR: luckys-lnz <github.com/luckys-lnz>
" SOURCE: https://github.com/luckys-lnz/my_vimrc_config/blob/main/.vimrc
" MODIFIED: 1/8/2024
" LANGUAGES_SUPPORTED: Python, C, JS, TS, HTML, CSS 
" NOTE: THIS FILE MIGHT NOT MEET ALL REQUIREMENT OF THE SUPPORTED LANGUAGES,
"       AND SOME PLUGINS MIGHT BE DUPLICATES.. I WILL LOOK INTO THAT LATER
"       AS I TRY TO MAKE MY CONFIG MEET MY TASTE.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"----------------------------------------------------------------------------------------------------------

" 1. OS specific

    if ($OS == 'Windows_NT')
        " Windows specific settings

        " 1.1 Restore cursor to file position in previous editing session http://vim.wikia.com/wiki/VimTip80
        set viminfo='10,\"100,:20,%,n$VIM/_viminfo

        " 1.2 executing OS command within Vim
        set shell=c:\Windows\system32\cmd.exe
        " shell command flag
        set shellcmdflag=/c
    else
        " Unix specific settings
        " 1.1 : pick it from $HOME/.viminfo
        set viminfo='10,\"100,:20,%,n~/.viminfo

        " 1.2 executing OS command within Vim
        set shell=/bin/csh
    endif

"----------------------------------------------------------------------------------------------------------


"{{{ Behaviour
set encoding=utf8
let mapleader=","
set nocompatible
set number                " Show numbers on the left
set relativenumber        " Its better if you use motions like 10j or 5yk
set hlsearch              " Highlight search results
set ignorecase            " Search ignoring case
set smartcase             " Do not ignore case if the search patter has uppercase
set noerrorbells          " I hate bells when an error occurs
set belloff=esc           " Disable bell if type <esc> multiple times
"set tabstop=4             " Tab size of 4 spaces
"set softtabstop=4         " On insert use 4 spaces for tab
"set shiftwidth=0
"set expandtab             " Use appropriate number of spaces (no so good for PHP)
set nowrap                " Wrapping sucks (except on markdown)
set noswapfile            " Do not leave any backup files
set mouse=i               " Enable mouse on insert mode
set clipboard=unnamed,unnamedplus     " Use the OS clipboard
set showmatch             " Highlights the matching parenthesis
set termguicolors         " Required for some themes
set splitright splitbelow " Changes the behaviour of vertical and horizontal splits
set foldlevel=1           " Better for markdown and PHP classes
set cursorline            " Highlight the current cursor line (Can slow the UI)
set signcolumn=yes        " Always show the signcolumn, otherwise it would shift the text
set hidden                " Allow multple buffers
set completeopt=menuone,noinsert,noselect " Let the user decide about the autocomplete
filetype plugin indent on " Enable file type detection.
let &t_EI = "\e[2 q"      " Make cursor a line in insert on Vim
let &t_SI = "\e[6 q"      " Make cursor a line in insert on Vim
set title                 " Show file title
set wildmenu " Show a more advance menu
set spell " enable spell check (may need to download language package)
syntax on
let g:kite_supported_languages = ['python', 'javascript']
filetype plugin indent on   " Allow auto-indenting depending on file type
let fancy_symbols_enabled = 1
let using_neovim = has('nvim')
let using_vim = !using_neovim
let transparent_background = 0
set textwidth=79

:inoremap <C-v> <ESC>"+pa
:vnoremap <C-c> "+y
:vnoremap <C-d> "+d

" Keep Visual Mode after indenting a block with > or <
vmap < <gv
vmap > >gv


" Move Visual blocks up or down with J an K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" YY/XX Copy/Cut into the system clipboard
noremap YY "+y<CR>
noremap XX "+x<CR>


" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

set guiheadroom=0
" Enable native markdown folding (hopefully will be integrated in nvim)
let g:markdown_folding = 1
" }}}


" {{{ Auto Commands
" Enable wrap on Markdown and Text files
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    setlocal wrap
    setlocal noshowmatch
    nnoremap <buffer> j gj
    nnoremap <buffer> k gk
  endfunction
endif
augroup vimrc-enable-wrap-on-text-files
  autocmd!
  autocmd BufRead,BufNewFile *.txt,*.md call s:setupWrapping()
augroup END


" Auto command to remember last editing position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END


" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" AutoOpen NetRW of called without parammters
augroup netrw-auto-open-if-no-params
  autocmd!
  autocmd VimEnter * if argc() == 0 | Explore! | endif
augroup END
" }}}


" {{{ Plugins

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'                               " Makes vim work as you'd expect

" Themes
Plug 'drewtempelmeyer/palenight.vim'                    " Soothing color scheme based on material palenight
Plug 'haishanh/night-owl.vim'                           " Hight contrast but relaxed theme
Plug 'mhartington/oceanic-next'                         " Beautiful pastell-y colors
Plug 'nanotech/jellybeans.vim'                          " Hight contrast but colorfoul

" Gruvbox theme and MesloLGLDZNerdfont
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'ryanoasis/vim-webdevicons'
Plug 'ryanoasis/nerd-fonts', {'on': 'NERDFonts'}
Plug 'ryanoasis/vim-devicons'

Plug 'sheerun/vim-polyglot'                             " Metapackage with a bunch of syntax highlight libs


" Plugins for JavaScript, TypeScript, TailwindCSS, Angular, Next.js, React.js, Node.js, Python, and C programming
" Make VIM an IDE
"Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockile'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'pangloss/vim-javascript'           " JavaScript syntax highlighting
Plug 'leafgarland/typescript-vim'        " TypeScript syntax highlighting
Plug 'windwp/nvim-ts-autotag'            " Auto closing and auto renaming tag for TypeScript and JSX
Plug 'sheerun/vim-polyglot'              " Language pack for Vim (includes syntax highlighting for many languages)
Plug 'posva/vim-vue'                     " Vue.js syntax highlighting
Plug 'peitalin/vim-jsx-typescript'       " JSX and TypeScript syntax highlighting

Plug 'jiangmiao/auto-pairs'              " Insert or delete brackets, parens, quotes in pair
Plug 'mattn/emmet-vim'                   " Emmet for Vim
Plug 'alvan/vim-closetag'                " Auto close tags
Plug 'carlitux/deoplete-ternjs'          " JavaScript completion using tern
Plug 'mhartington/oceanic-next'          " Color scheme
Plug 'lervag/vimtex'                     " LaTeX support

Plug 'liuchengxu/vista.vim'                             " Like Ctags but for LSP (CoC)
"Plug 'dense-analysis/ale'                               " Code sniffing using external tools
Plug 'tpope/vim-fugitive'                               " Like :!git but better


Plug 'itchyny/lightline.vim'                            " Beautify status line
Plug 'josa42/vim-lightline-coc'                         " Show CoC diagnostics in LightLine

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " File navigator with <C-k><C-k>
Plug 'Xuyuanp/nerdtree-git-plugin'                      " Show git status on NERDTree
Plug 'airblade/vim-gitgutter'                           " Show which lines changed on gutter
Plug 'editorconfig/editorconfig-vim'                    " Configure tab or spaces per project
Plug 'bogado/file-line'                                 " Enable opening vim like - vim my_file.php:8
Plug 'ryanoasis/vim-devicons'                           " Icons on NERDtree and Vista

Plug 'vim-airline/vim-airline'           " Status/tabline
Plug 'vim-airline/vim-airline-themes'    " Themes for vim-airline

Plug 'terryma/vim-multiple-cursors'                     " Multiple cursors like Sublime with <C-n>
Plug 'junegunn/vim-easy-align'                          " Align text by characters or reguex
Plug 'mattn/emmet-vim'                                  " Emmet support with <C-y>,
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " Install fuzzy finder binary
Plug 'junegunn/fzf.vim'                                 " Enable fuzzy finder in Vim with <C-p>
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Random plugs
Plug 'vim-scripts/indentpython.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'PhilRunninger/nerdtree-visual-selection'
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

""""""""""""""""""""""Nice config""""""""""""""""""""""
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Show git status in left bar
Plug 'airblade/vim-gitgutter'
" Show git status in Nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'

" [2] Twig syntax
Plug 'lepture/vim-jinja'

" [3] easily surround things... Nice intro video: https://www.youtube.com/watch?v=5HF4jSyPpvs
Plug 'tpope/vim-surround'

" [4] Themes / Prettify stuff
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'felixhummel/setcolors.vim'
Plug 'gko/vim-coloresque'
Plug 'hashivim/vim-vagrant'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'jwalton512/vim-blade'
Plug 'dylnmc/synstack.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'jparise/vim-graphql'

" [5] Search filesystem with ctrl+p (this fork replaces the old unmaintained project)
Plug 'ctrlpvim/ctrlp.vim'

" [6]

" [7] Comment out code
Plug 'vim-scripts/tComment' "Comment easily with gcc

" [8] Snippets
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'justinj/vim-react-snippets'
Plug 'mattn/emmet-vim'

" [9] Pretty format for our code
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }

" [10] Linting and LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" [11] Move code
Plug 'tpope/vim-unimpaired'

" [12] Auto close brackets, parenthesis, etc
Plug 'jiangmiao/auto-pairs'

" [13] Format php code
Plug 'stephpy/vim-php-cs-fixer'
Plug 'editorconfig/editorconfig-vim'

call plug#end()

" }}}


if using_vim
  " Consoles as buffers (neovim has its own consoles as buffers)
  Plug 'rosenfeld/conque-term'
  " XML/HTML tags navigation (neovim has its own)
  Plug 'vim-scripts/matchit.zip'
endif


if has("gui_running")
  if has("gui_gtk3")
    set guifont=RecMonoCasualNerdFont\ 10
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif


" remove ugly vertical lines on window division
set fillchars+=vert:\

" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256')
  if !has('gui_running')
    let &t_Co = 256
  endif
  " Set colorscheme to Gruvbox
  let g:gruvbox_italic=1
  colorscheme gruvbox
  let g:gruvbox_bold=1
  set background=dark
  let g:gruvbox_underline=0
  let g:gruvbox_contrast_dark=1
else
  colorscheme delek
endif

if transparent_background
  highlight Normal guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
endif


"============================================================================
" Colorscheme configuration

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif




" {{{ Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Setup formatexpr specified filetype(s).
autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

" Update signature help on jump placeholder
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Apply codeAction to the selected region
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position.
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer.
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" }}}

"{{{
let g:user_emmet_settings = {
      \  'javascript' : {
      \      'extends' : 'jsx',
      \  },
      \}
"}}}


" {{{ CoC extensions to be auto installed
let g:coc_node_args = ['--max-old-space-size=8192']
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-diagnostic',
      \ 'coc-eslint',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-marketplace',
      \ 'coc-phpls',
      \ 'coc-prettier',
      \ 'coc-stylelintplus',
      \ 'coc-tsserver',
      \]
" }}}
" \ 'coc-python',

"{{{ ALE configuration
let g:ale_fixers = {
      \  'javascript': ['prettier'],
      \  'typescript': ['prettier'],
      \  'css': ['prettier'],
      \  'html': ['prettier'],
      \}
let g:ale_linters = {
      \  'javascript': ['eslint'],
      \  'typescript': ['tslint'],
      \}
let g:ale_fix_on_save = 1
"}}}

" {{{
" Remap keys for apply refactor code actions.
nmap <leader>re <Plug>(coc-codeaction-refactor)
xmap <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <leader>r  <Plug>(coc-codeaction-refactor-selected)
"}}}

" {{{ CoC (taken from github.com/neoclide/coc.nvim some comments removed)

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" [11]
" Move single lines
nmap <C-k> [e
nmap <C-j> ]e
" Move multiple lines selected
vmap <C-k> [egv
vmap <C-j> ]egv


" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" }}}


au BufNewFile,BufRead *.twig set ft=jinja "Syntax highlight twig files

" Show syntax highlighting groups for word under cursor
:nmap <leader>ss <plug>(SynStack)


"{{{ [5]
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher (a lot
" faster than grep)
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_working_path_mode = 'r'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  let g:ctrlp_extensions = ['line']
endif
"}}}

""""""""""""""""""""Airline Config"""""""""""""""""""""""""""
let g:airline_powerline_fonts=1
" Enable the Airline tabline extension
let g:airline#extensions#tabline#enabled = 1

" Customize the tabline
let g:airline#extensions#tabline#tab_nr_type = 1

" Set tab name format
function! SetTabName()
  return printf('%d: %s', tabpagenr(), bufname('%'))
endfunction

" Use the function to set tab names
let g:airline#extensions#tabline#tab_labels = 'SetTabName()'


"-- ULTISNIPS CONFIG
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<c-l>"

"-- INDENTLINE CONFIG
let g:indentLine_color_gui = '#423d38'
let g:indentLine_setConceal = 0
let g:indentLine_char = '|'

" {{{ Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"}}}

" {{{
" tab navigation mappings
map tt :tabnew
map <M-Right> :tabn<CR>
imap <M-Right> <ESC>:tabn<CR>
map <M-Left> :tabp<CR>
imap <M-Left> <ESC>:tabp<CR>
" }}}


" {{{ ALE
let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
      \ 'python': ['pylint']
      \ }
let g:ale_fixers = {
      \ 'php': ['phpcbf'],
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
"}}}


" {{{ LightLine
function! LightLineFilename()
  return expand('%')
endfunction
set statusline+=%h
" Configure the sections of the statusline
" Path to file: https://github.com/itchyny/lightline.vim/issues/87#issuecomment-119130738
let g:lightline = { 'active': {  } }
let g:lightline.component = {
      \  'lineinfo': "[%{printf('%03d/%03d',line('.'),line('$'))}]"
      \}
let g:lightline.component_function = {
      \    'gitbranch': 'fugitive#head',
      \    'method': 'NearestMethodOrFunction',
      \    'filename': 'LightLineFilename'
      \  }
" When using ALE for diagnostics
" let g:lightline.component_expand = {
"       \  'linter_checking': 'lightline#ale#checking',
"       \  'linter_infos': 'lightline#ale#infos',
"       \  'linter_warnings': 'lightline#ale#warnings',
"       \  'linter_errors': 'lightline#ale#errors',
"       \  'linter_ok': 'lightline#ale#ok',
"       \ }
" " When using CoC's diagnostics-languageserver for diagnostics
let g:lightline.component_expand = {
      \   'linter_warnings': 'lightline#coc#warnings',
      \   'linter_errors': 'lightline#coc#errors',
      \   'linter_ok': 'lightline#coc#ok',
      \   'status': 'lightline#coc#status',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
let g:lightline.active.left = [
      \      [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
      \      [ 'coc_errors', 'coc_warnings', 'coc_ok' ], [ 'coc_status'  ],
      \      [ 'gitbranch', 'readonly', 'filename', 'tagbar', 'modified', 'method' ]
      \]
let g:lightline.active.right = [
      \      ['lineinfo'], ['fileformat', 'filetype']
      \]
" https://github.com/itchyny/lightline.vim/tree/master/autoload/lightline/colorscheme
" let g:lightline.colorscheme = 'materia' " Works better with oceanic
let g:lightline.colorscheme = 'gruvbox' " Works better with palenight 'nord'
" let g:lightline.colorscheme = 'selenized_dark' " Goes great with night owl
" }}}


" {{{ NERDTree
let NERDTreeMinimalUI=1    " Remove the help at the top
let NERDTreeQuitOnOpen=1   " Close sidebar when opening a file
let NERDTreeShowHidden=1   " Do I have to explain this
let NERDTreeWinPos='right' " Or this?
let NERDTreeWinSize=45     " Increase the sidebar size

" Tagbar -----------------------------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" NERDTree -----------------------------

" toggle nerdtree display
map <C-t> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>

" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']" Do not show lightline on NERDTree
augroup nerdtree-normal-statusline
  autocmd!
  autocmd BufEnter,FileType nerdtree setlocal statusline=%#Normal#
augroup END
" }}}


" {{{ EasyAlign. Start interactive modes in visual and motion/text objects
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}


" {{{ Vim commentary
autocmd FileType php setlocal commentstring=//\ %s
" }}}


" {{{ FzF
" Fzf ------------------------------
" let g:fzf_layout = { 'down': '~20%' }
let g:fzf_layout = { 'window': { 'width': 0.5, 'height': 0.5 } }

" file finder mapping
nmap ,e :Files<CR>
" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>
" the same, but with the word under the cursor pre filled
nmap ,wg :execute ":BTag " . expand('<cword>')<CR>
" tags (symbols) in all files finder mapping
nmap ,G :Tags<CR>
" the same, but with the word under the cursor pre filled
nmap ,wG :execute ":Tags " . expand('<cword>')<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wf :execute ":BLines " . expand('<cword>')<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wF :execute ":Lines " . expand('<cword>')<CR>
" commands finder mapping
nmap ,c :Commands<CR>
" }}}

" {{{ Markdown Preview. Do not autoclose on change buffer and refresh only on normal
let g:mkdp_auto_close = 0
let g:mkdp_refresh_slow = 1
let g:mkdp_preview_options = {
      \ 'sync_scroll_type': 'relative',
      \ 'disable_sync_scroll': 1,
      \ 'disable_filename': 1
      \ }
" }}}
