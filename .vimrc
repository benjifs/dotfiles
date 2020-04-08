
" Plugins {{{
" Install vim-plug automatically
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'noahfrederick/vim-noctu'
Plug 'mhinz/vim-startify'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-commentary'
Plug 'vimwiki/vimwiki'
call plug#end()

" Automatically install missing plugins on startup
" https://github.com/junegunn/vim-plug/wiki/extra
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
" }}}

" General {{{
set nocompatible                                         " Off by default but better safe than sorry
set hidden                                               " Hide buffer instead of closing
set history=500                                          " Set history to 500
set lazyredraw                                           " Redraw only when we need to
set ttyfast                                              " Optimize for fast terminal connections
" set mouse=a                                              " Enable mouse in all modes
set noerrorbells                                         " Disable error bells
set nostartofline                                        " Don’t reset cursor to start of line when moving around
set title                                                " Show the filename in the window titlebar
set shortmess=atI                                        " Don’t show the intro message when starting Vim
set showmode                                             " Show the current mode
set encoding=utf8                                        " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac                                     " Use Unix as the standard file type
set backspace=indent,eol,start                           " Allow backspace
set nopaste                                              " Fix pasting from clipboard
set laststatus=2                                         " Always show the status line
" set clipboard^=unnamed,unnamedplus                       " Shared clipboard
set splitbelow splitright                                " Split to right or below by default
" }}}

" UI {{{
syntax enable                                            " Enable syntax processing
colorscheme noctu
set relativenumber                                       " Display relative line numbers
set number                                               " Display the absolute line number at the line you're on
set numberwidth=2                                        " Keep the line number gutter narrow so three digits is cozy
set cursorline                                           " Highlight current line
set ruler                                                " Show the cursor position
set colorcolumn=80                                       " Draw line at column 80 to prevent going too far
set showmatch                                            " Highlight matching [{()}]
set list                                                 " Show invisible characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_,space:·             " Invisibles
" }}}

" Tabs and spaces {{{
set tabstop=2                                            " number of visual spaces per TAB
set shiftwidth=2
set autoindent                                           " Indent at the same level of the previous line
set smartindent                                          " Turn on smart indents
set noexpandtab                                          " Use tabs instead of spaces
set wrap                                                 " Wrap lines
" }}}

" Commands {{{
set showcmd                                              " Show the (partial) command as it’s being typed
set wildmenu                                             " Visual autocomplete for command menu. USAGE :e ~/.vim<TAB>
set wildmode=list:longest,full
" }}}

" Search {{{
set incsearch                                            " Search as characters are entered
set hlsearch                                             " Highlight matches
set ignorecase                                           " Ignore case of searches
set smartcase                                            " Unless uppercase is used
" }}}

" Folding {{{
set foldenable                                           " Enable folding
set foldlevelstart=10                                    " Open most folds by default
set foldnestmax=10                                       " 10 nested fold max
set foldmethod=syntax                                    " Fold based on indent level
" }}}

" Backups, swaps and undos {{{
call system('mkdir ~/.vim')                              " Creating .vim directories if they dont exist
call system('mkdir ~/.vim/backups')
call system('mkdir ~/.vim/swaps')
call system('mkdir ~/.vim/undo')
set backupdir=~/.vim/backups                             " Setting backup, swap and undo directories
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif
" }}}

" Mappings {{{
let mapleader=","                                        " Set leader to ,

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>
" Turn off search highlighting
nnoremap <leader><leader> :noh<CR>

" Move to previous buffer
nnoremap <bs> <c-^>

" Tabs
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>

" Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}

" autocmd {{{
if has("autocmd")
	filetype on                                                             " Enable file type detection
	filetype indent on                                                      " Enable file type indentation
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript    " Treat .json files as .js
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown              " Treat .md files as Markdown
	autocmd FileType * setlocal formatoptions-=cro                          " Disable continuing comments on newline
endif
" }}}

" netrw (github/changemewtf) {{{
let g:netrw_banner=0                                     " disable banner
let g:netrw_browse_split=4                               " open in prior window
let g:netrw_altv=1                                       " open splits to the right
let g:netrw_liststyle=3                                  " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" }}}

" vimwiki
let g:vimwiki_list = [{'path': $WORKSPACE . '/wiki',
	\ 'syntax': 'markdown',
	\ 'ext': '.md'}]

" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" modeline not working in macOS without this
set modeline
set modelines=1
" vim: fdm=marker fmr={{{,}}}
