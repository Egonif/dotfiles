"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|

set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin on

" Auto-completion
set omnifunc=syntaxcomplete
set omnifunc=pythoncomplete

" Vim-Plug
call plug#begin('~/.vim/plugged')

" List of plugins
Plug 'dense-analysis/ale'
Plug 'nvie/vim-flake8'
Plug 'raimondi/delimitmate'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-multiselect'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'
Plug 'andrewradev/tagalong.vim'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'ervandew/supertab'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

syntax on

set t_Co=256

" Define color theme
" set background=dark
" colorscheme solarized

set foldmethod=indent

set foldlevel=99

nnoremap <space> za

au BufNewFile, BufRead *.py
    \ set tabstop=7
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

let g:ale_linters = {'python': ['flake8']}

" Show number on the left and relative number
set number
set ruler
" set relativenumber

" Activate mouse interaction
set mouse=a

" Visual Studio Code Shortcuts
map <A-Down> yyp
map <A-Up> yyP

" Multiselect plugins shortcuts
nmap <Space>v <Plug>(multiselect-checksearched)

" NERDTree shortcuts
map N :NERDTree<CR>
let NERDTreeShowHidden=1

" Python shortcuts
map <F5> :w<CR>:! clear ; python3 %<CR>

" Emmet shortcuts
let g:user_emmet_leader_key=','

" Split preferences
set splitbelow splitright

" Airline preferences
let g:airline_theme='night_owl'
