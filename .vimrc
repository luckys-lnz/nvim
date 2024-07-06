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

syntax enable
set mouse=a
set number
set cursorline
set backspace=indent,eol,start
set scrolloff=3
set hidden
set wildmenu
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set background=dark
set showmode
set laststatus=2
set ruler
set showcmd
set cmdheight=2
set updatetime=300
set signcolumn=yes
set completeopt=menuone,noselect
set shortmess+=c
set splitright
set splitbelow
" Enable 24 bit color
set termguicolors
 " required for some plugins
set nocompatible
" copy to clipboard outside vim
set clipboard=unnamedplus
set guioptions+=a

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
