" Luckys-vim-config
" http://luckyarchi.tech

let fancy_symbols_enabled = 1
" To use the background color of your terminal app, change this setting from 0
" to 1
let transparent_background = 0

set encoding=utf-8
let using_neovim = has('nvim')
let using_vim = !using_neovim

" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

" ============================================================================
" Vim-plug initialization
" Don't modify this part unless yur'e as Good as I"

let vim_plug_just_installed = 0
if using_neovim
    let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
else
    let vim_plug_path = expand('~/.vim/autoload/plug.vim')
endif
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    if using_neovim
        silent !mkdir -p ~/.config/nvim/autoload
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        silent !mkdir -p ~/.vim/autoload
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the config down below 
" as you wish :)
" FYI: some things in the config are vim or neovim specific. It's easy 
" to spot, they are inside `if using_vim` or `if using_neovim` blocks.

" ============================================================================
" Active plugins
" You can add new plugins here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
if using_neovim
    call plug#begin("~/.config/nvim/plugged")
else
    call plug#begin("~/.vim/plugged")
endif

" Now the actual plugins:

" Override configs by directory
Plug 'arielrossanigo/dir-configs-override.vim'
" Code commenter
Plug 'scrooloose/nerdcommenter'
" Better file browser
Plug 'scrooloose/nerdtree'
" Class/module browser
Plug 'majutsushi/tagbar'
" Search results counter
Plug 'vim-scripts/IndexedSearch'
" A couple of nice colorschemes
Plug 'morhetz/gruvbox'
Plug 'patstockwell/vim-monokai-tasty'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Async autocompletion
if using_neovim && vim_plug_just_installed
    Plug 'Shougo/deoplete.nvim', {'do': ':autocmd VimEnter * UpdateRemotePlugins'}
else
    Plug 'Shougo/deoplete.nvim'
endif
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" Python autocompletion
Plug 'deoplete-plugins/deoplete-jedi'
" Completion from other opened files
Plug 'Shougo/context_filetype.vim'
" Just to add the python go-to-definition and similar features, autocompletion
Plug 'davidhalter/jedi-vim'
" Automatically close parenthesis, etc
Plug 'Townk/vim-autoclose'
" Surround
Plug 'tpope/vim-surround'
" Indent text object
Plug 'michaeljsmith/vim-indent-object'
" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'
" Better language packs
Plug 'sheerun/vim-polyglot'
" Ack code search (requires ack installed in the system)
Plug 'mileszs/ack.vim'
" Paint css colors with the real color
Plug 'ap/vim-css-color'
" Window chooser
Plug 't9md/vim-choosewin'
" Automatically sort python imports
Plug 'fisadev/vim-isort'
" Highlight matching html tags
Plug 'valloric/MatchTagAlways'
" Generate html in a simple way
Plug 'mattn/emmet-vim'
" Git integration
Plug 'tpope/vim-fugitive'
" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'
" Yank history navigation
Plug 'vim-scripts/YankRing.vim'
" Linters
Plug 'neomake/neomake'
" Nice icons in the file explorer and file type status line.
Plug 'ryanoasis/vim-devicons'

if using_vim
    " Consoles as buffers (neovim has its own consoles as buffers)
    Plug 'rosenfeld/conque-term'
    " XML/HTML tags navigation (neovim has its own)
    Plug 'vim-scripts/matchit.zip'
endif

" Code searcher. If you enable it, you should also configure 
" g:hound_base_url 
" and g:hound_port, pointing to your hound instance
" Plug 'mattn/webapi-vim'
" Plug 'jfo/hound.vim'

" Web development plugins
Plug 'peitalin/vim-jsx-typescript'
Plug 'jparise/vim-graphql'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'groenewege/vim-less'
Plug 'cakebaker/scss-syntax.vim'
Plug 'evanleck/vim-svelte'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'ekalinin/Dockerfile.vim'
Plug 'hashivim/vim-terraform'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'cespare/vim-toml'
Plug 'jvirtanen/vim-hcl'
Plug 'mustache/vim-mustache-handlebars'

"--------------------------New confing------------------
" Specify the plugin manager (vim-plug)
call plug#begin('~/.vim/plugged')

" Plugins for JavaScript, TypeScript, TailwindCSS, Angular, Next.js, React.js, Node.js, Python, and C programming
Plug 'pangloss/vim-javascript'           " JavaScript syntax highlighting
Plug 'leafgarland/typescript-vim'        " TypeScript syntax highlighting
Plug 'windwp/nvim-ts-autotag'            " Auto closing and auto renaming tag for TypeScript and JSX
Plug 'sheerun/vim-polyglot'              " Language pack for Vim (includes syntax highlighting for many languages)
Plug 'posva/vim-vue'                     " Vue.js syntax highlighting
Plug 'peitalin/vim-jsx-typescript'       " JSX and TypeScript syntax highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Intellisense engine (for JavaScript, TypeScript, CSS, etc.)
Plug 'preservim/nerdtree'                " File explorer
Plug 'tpope/vim-fugitive'                " Git wrapper
Plug 'airblade/vim-gitgutter'            " Git gutter signs
Plug 'vim-airline/vim-airline'           " Status/tabline
Plug 'vim-airline/vim-airline-themes'    " Themes for vim-airline
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }  " Fuzzy finder
Plug 'junegunn/fzf.vim'                  " Fzf integration for Vim
Plug 'dense-analysis/ale'                " Asynchronous linting engine
Plug 'fatih/vim-go', { 'tag': '*' }      " Go development
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}  " Snippets for coc.nvim
Plug 'maxmellon/vim-jsx-pretty'          " JSX formatting
Plug 'styled-components/vim-styled-components'  " Syntax highlighting for styled-components in JavaScript and TypeScript
Plug 'windwp/nvim-autopairs'             " Auto closing pairs
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Treesitter for better syntax highlighting
Plug 'tpope/vim-surround'                " Manipulate surrounding characters
Plug 'jiangmiao/auto-pairs'              " Insert or delete brackets, parens, quotes in pair
Plug 'mattn/emmet-vim'                   " Emmet for Vim
Plug 'alvan/vim-closetag'                " Auto close tags
Plug 'carlitux/deoplete-ternjs'          " JavaScript completion using tern
Plug 'mhartington/oceanic-next'          " Color scheme
Plug 'lervag/vimtex'                     " LaTeX support

" Gruvbox theme and MesloLGLDZNerdfont
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'ryanoasis/vim-webdevicons'
Plug 'ryanoasis/nerd-fonts', {'on': 'NERDFonts'}
Plug 'ryanoasis/vim-devicons'


" Coc extensions
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}  " TSServer extension for coc.nvim
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}      " JSON extension for coc.nvim
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}      " HTML extension for coc.nvim
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}       " CSS extension for coc.nvim
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}    " Python extension for coc.nvim
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}  " Prettier extension for coc.nvim

call plug#end()

" Automatically install plugins if vim-plug was just installed
if vim_plug_just_installed
    execute 'PlugInstall --sync'
endif

" ============================================================================
" Codecs support
if using_vim
    set fileencodings=ucs-bom,utf-8,default,latin1
else
    set fileencodings=ucs-bom,utf8,default,latin1
endif

" ============================================================================
" Filetype and indentation configuration
" Custom config per filetype
filetype plugin indent on

" ============================================================================
" Basic configuration

" lnz vim config -> modified
" {{{ Behaviour
let mapleader=","
set nocompatible
set number                " Show numbers on the left
set relativenumber        " Its better if you use motions like 10j or 5yk
set hlsearch              " Highlight search results
set ignorecase            " Search ignoring case
set smartcase             " Do not ignore case if the search patter has uppercase
set noerrorbells          " I hate bells when an error occurs
set belloff=esc           " Disable bell if type <esc> multiple times
set tabstop=4             " Tab size of 4 spaces
set softtabstop=4         " On insert use 4 spaces for tab
set shiftwidth=0
" set expandtab             " Use appropriate number of spaces (no so good for PHP)
set nowrap                " Wrapping sucks (except on markdown)
set noswapfile            " Do not leave any backup files
set mouse=i               " Enable mouse on insert mode
"set clipboard=unnamed,unnamedplus     " Use the OS clipboard
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

call plug#end()
" }}}


" {{{ Theme(s) settings
if !has('nvim')
    " Enable italics in Vim 8
"    let &t_ZH="\e[3m"
 "   let &t_ZR="\e[23m"
endif
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_palette = 'mix'
let g:palenight_terminal_italics = 1
let g:vim_monokai_tasty_italic = 1
let g:jellybeans_use_term_italics = 1

"============================================================================
" Colorscheme configuration

if has("termguicolors")
    set termguicolors
endif

" Set colorscheme to Gruvbox
colorscheme gruvbox

" Set font to MesloLGLDZNerdfont
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'

" silent! colorscheme night-owl
" silent! colorscheme palenight
" silent! colorscheme OceanicNext
" silent! colorscheme gruvbox
" silent! colorscheme jellybeans
 " }}}

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
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


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


" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" }}}


" {{{ Vista
" let g:vista_default_executive = 'coc'
" let g:vista#renderer#enable_icon = 1
" let g:vista_sidebar_width = 45
" let g:vista_close_on_jump = 1
" let g:vista_close_on_fzf_select = 1
" let g:vista_fzf_preview = ['right:50%']
nnoremap <C-k><C-o> :Vista finder fzf:coc<cr>
" }}}


" {{{ Fancy Symbols!!
let fancy_symbols_enabled = 1
if fancy_symbols_enabled
   let g:webdevicons_enable = 1
   " custom airline symbols
   if !exists('g:airline_symbols')
      let g:airline_symbols = {}
   endif
   let g:airline_left_sep = ''
   let g:airline_left_alt_sep = ''
   let g:airline_right_sep = ''
   let g:airline_right_alt_sep = ''
   let g:airline_symbols.branch = '⭠'
   let g:airline_symbols.readonly = '⭤'
   let g:airline_symbols.linenr = '⭡'
else
   let g:webdevicons_enable = 0
endif
" }}}

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
map <C-k><C-k> :NERDTreeToggle<cr>
map <C-k><C-f> :NERDTreeFind<cr>
" Do not show lightline on NERDTree
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


"============================================================================
" Colorscheme configuration

if has("termguicolors")
    set termguicolors
endif

" Set colorscheme to Gruvbox
colorscheme gruvbox

" Set font to MesloLGLDZNerdfont
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'

" ============================================================================
" Plugin-specific configuration

" vim-airline configuration
let g:airline_powerline_fonts = 1

" NERDTree configuration
nmap <silent> <C-n> :NERDTreeToggle<CR>

" ALE configuration
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'css': ['prettier'],
\   'html': ['prettier'],
\}
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\}
let g:ale_fix_on_save = 1

" FZF configuration
let g:fzf_layout = { 'down': '~40%' }

" Coc.nvim configuration
let g:coc_global_extensions = [
\ 'coc-tsserver',
\ 'coc-json',
\ 'coc-html',
\ 'coc-css',
\ 'coc-python',
\ 'coc-prettier',
\ 'coc-snippets'
\]
" Use tab for trigger completion with characters ahead and navigate
" Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim-0.5.1') || !has('patch-8.2.0750')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
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

" Remap keys for apply refactor code actions.
nmap <leader>re <Plug>(coc-codeaction-refactor)
xmap <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens actions on the current line.
nmap <leader>cl <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide statusline plugins such as `lightline.vim`.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
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

" ============================================================================
" Terminal mappings
tnoremap <silent> <Esc> <C-\><C-n>
nnoremap <silent> <C-\> :vsp term://zsh<CR>
nnoremap <silent> <C-_> :sp term://zsh<CR>

" ============================================================================
