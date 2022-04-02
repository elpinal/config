syntax on

set autoindent
set backspace=indent,eol,start
set belloff=all
set directory=~/tmp/vim
set expandtab
" let &grepprg='rg --vimgrep'
let &grepprg='git grep --line-number'
set hlsearch
set incsearch
set laststatus=2
set mouse=a
set shiftwidth=2
set showcmd
set softtabstop=2

" https://github.com/kana/config/blob/5e3acc0df630048f48e53073a1816e106dbffd15/vim/personal/dot.vimrc#L256
let &statusline = ''
let &statusline .= '%<%f %h%m%r%w'
let &statusline .= '%='
let &statusline .= '['
let &statusline .=   '%{&l:fileencoding == "" ? &encoding : &l:fileencoding}'
let &statusline .=   '%{&l:bomb ? "/BOM" : ""}'
let &statusline .= ']'
let &statusline .= '[%{&l:fileformat}]'
let &statusline .= '  %-14.(%l,%c%V%) %P'

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

noremap <expr> n (v:searchforward ? 'n' : 'N')
noremap <expr> N (v:searchforward ? 'N' : 'n')

nnoremap <C-k> <C-o>
nnoremap <C-j> <C-i>

nnoremap ; <C-]>


"" Plugins

packloadall

call skkeleton#config({ 'globalJisyo': '~/.skk/SKK-JISYO.L' })
imap <C-j> <Plug>(skkeleton-enable)
cmap <C-j> <Plug>(skkeleton-enable)
