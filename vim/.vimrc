syntax on

set autoindent
set backspace=indent,eol,start
set belloff=all
set directory=~/tmp/vim
set expandtab
set hlsearch
set incsearch
set mouse=a
set shiftwidth=2
set showcmd
set softtabstop=2

inoremap <C-l> <C-[>

nnoremap <CR> :
vnoremap <CR> :
nnoremap : <CR>
vnoremap : <CR>

nnoremap <C-h> :help<Space>

nnoremap <Tab> <C-w><C-w>
nnoremap <Esc>c <C-w>c
nnoremap <Esc>y <C-w>v

nnoremap <Esc>q <C-w>q

nnoremap <Space> <Nop>
nnoremap <silent> <Space>/ :nohlsearch<CR>
