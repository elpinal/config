syntax on

filetype plugin indent on

set autoindent
set backspace=indent,eol,start
set belloff=all
set directory=~/tmp/vim
set expandtab
" let &grepprg='rg --vimgrep'
let &grepprg='git grep --line-number'
set hlsearch
nohlsearch " Don't highlight when reloading vimrc.
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

function! MyTabLabel(n)
  let cwd = getcwd(-1, a:n)
  if cwd == '/'
    return cwd
  elseif cwd == expand('~')
    return '~'
  else
    return fnamemodify(cwd, ":t")
  endif
endfunction

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    let s .= '%' . (i + 1) . 'T'

    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  let s .= '%#TabLineFill#%T'

  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

set tabline=%!MyTabLine()

inoremap <C-l> <C-[>
inoremap <C-@> <C-[>

inoremap <C-a> <Home>

nnoremap <CR> :
vnoremap <CR> :
nnoremap : <CR>
vnoremap : <CR>

nnoremap @<CR> @:
nnoremap ; <C-]>

nnoremap <C-h> :help<Space>

""" tabs
nnoremap t <Nop>
nnoremap <silent> tn :tabnew<CR>
nnoremap <silent> tj :tabnext<CR>
nnoremap <silent> tk :tabprev<CR>
nnoremap <silent> th :tabmove -1<CR>
nnoremap <silent> tl :tabmove +1<CR>

nnoremap <Tab> <C-w><C-w>
nnoremap <Esc>c <C-w>c
nnoremap <Esc>y <C-w>v
nnoremap <Esc>q <C-w>q
nnoremap <Esc><CR> <C-w>:
nnoremap <C-w><CR> <C-w>:

""" Spaces: https://github.com/kana/config/blob/5e3acc0df630048f48e53073a1816e106dbffd15/vim/personal/dot.vimrc#L1784
map <Space> [Space]
noremap [Space] <Nop>
nnoremap <silent> [Space]/ :nohlsearch<CR>

command! -bar -nargs=+ Hecho  call s:cmd_Hecho('echo', [<f-args>])
function! s:cmd_Hecho(echo_command, args)
  let highlight_name = a:args[0]
  let messages = a:args[1:]

  execute 'echohl' highlight_name
  execute a:echo_command join(messages)
  echohl None
endfunction

function! s:keys_to_insert_one_character()
  Hecho ModeMsg '-- INSERT (one char) --'
  return nr2char(getchar()) . "\<Esc>"
endfunction

nnoremap [Space]A A<C-r>=<SID>keys_to_insert_one_character()<Return>
nnoremap [Space]a a<C-r>=<SID>keys_to_insert_one_character()<Return>

nnoremap [Space]I I<C-r>=<SID>keys_to_insert_one_character()<Return>
nnoremap [Space]i i<C-r>=<SID>keys_to_insert_one_character()<Return>

nnoremap [Space]h zc
nnoremap [Space]l zo

nnoremap <silent> [Space]e :setlocal encoding? termencoding? fileencoding? fileencodings?<Return>
nnoremap <silent> [Space]f :setlocal filetype? fileencoding? fileformat?<Return>
nnoremap <silent> [Space]r :registers<Return>

nnoremap <silent> [Space]<CR><CR> :source %<Return>
nnoremap <silent> [Space]<CR>. :source ~/.vimrc<Return>

noremap [Space]t t

" cmdline: https://github.com/kana/config/blob/5e3acc0df630048f48e53073a1816e106dbffd15/vim/personal/dot.vimrc#L1708
cnoremap <Esc>h <Left>
cnoremap <Esc>j <Down>
cnoremap <Esc>k <Up>
cnoremap <Esc>l <Right>
cnoremap <Esc>H <Home>
cnoremap <Esc>L <End>
cnoremap <Esc>w <S-Right>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>x <Del>

cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'

inoremap <Esc>h <Left>
inoremap <Esc>j <Down>
inoremap <Esc>k <Up>
inoremap <Esc>l <Right>

inoremap <Esc>w <C-Right>
inoremap <Esc>b <C-Left>
inoremap <Esc>e <C-o>e
inoremap <Esc>W <C-o>W
inoremap <Esc>B <C-o>B
inoremap <Esc>E <C-o>E

noremap <expr> n (v:searchforward ? 'n' : 'N')
noremap <expr> N (v:searchforward ? 'N' : 'n')

nnoremap <C-k> <C-o>
nnoremap <C-j> <C-i>

" unused keys
inoremap <C-u> <Nop>
inoremap <C-z> <Nop>

" experimental
set number
noremap j gj
noremap k gk
noremap 0 g0
noremap $ g$
noremap gj j
noremap gk k
noremap g0 0
noremap g$ $


"" Plugins

packadd vim-jetpack
call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1} " bootstrap

Jetpack 'cohama/lexima.vim'
Jetpack 'elpinal/forester.vim', {'ft': 'forester'}
Jetpack 'kana/vim-textobj-line'
Jetpack 'kana/vim-textobj-user'
Jetpack 'lambdalisue/fern-git-status.vim'
Jetpack 'lambdalisue/fern.vim'
Jetpack 'lervag/vimtex'
Jetpack 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Jetpack 'machakann/vim-sandwich'
Jetpack 'neoclide/coc.nvim', {'branch': 'release'}
Jetpack 'sainnhe/everforest'
Jetpack 'vim-denops/denops.vim', {'tag': 'v3.4.2'} " v3.4.2 for vim 8.
Jetpack 'vim-skk/skkeleton'
call jetpack#end()

" Install if not installed yet.
" No update is performed automatically.
for name in jetpack#names()
  if !jetpack#tap(name)
    call jetpack#sync()
    break
  endif
endfor

colorscheme everforest

call skkeleton#config({ 'globalDictionaries': ['~/.skk/SKK-JISYO.L'] })
imap <C-j> <Plug>(skkeleton-enable)
cmap <C-j> <Plug>(skkeleton-enable)
imap <C-b> <Plug>(skkeleton-disable)
cmap <C-b> <Plug>(skkeleton-disable)

" vim-sandwich
let g:sandwich_no_default_key_mappings = 1

nmap [Space]s <Plug>(sandwich-add)
xmap [Space]s <Plug>(sandwich-add)
omap [Space]s <Plug>(sandwich-add)

nmap [Space]d <Plug>(sandwich-delete)
xmap [Space]d <Plug>(sandwich-delete)

" Fern
let g:fern#default_hidden = 1

function! s:init_fern() abort
  nmap <buffer> - <Plug>(fern-action-leave)
  nnoremap <buffer> <C-h> :help<Space>
  nnoremap <buffer> t <Nop>
endfunction

augroup my-fern
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

nnoremap <silent> [Space]. :Fern -drawer .<CR>
nnoremap <silent> [Space]~ :Fern -drawer ~<CR>
nnoremap <silent> [Space]% :Fern -drawer %:h<CR>
nnoremap [Space]F :Fern -drawer<Space>

" vim-clap
nnoremap <silent> [Space]c :Clap<CR>
nnoremap <silent> [Space]m :Clap history<CR>

" coc.nvim
let g:coc_global_extensions =
      \ [ 'coc-forester'
      \ , 'coc-git'
      \ , 'coc-json'
      \ , 'coc-snippets'
      \ , 'coc-tsserver'
      \ ]

hi CocMenuSel ctermbg=237 guibg=#13354A
hi CocFloating ctermbg=8 guibg=#13354A

inoremap <expr> <C-y> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"

nnoremap <silent> [Space]h :call CocActionAsync('doHover')<CR>

inoremap <silent><expr> <C-q> coc#refresh()

imap <C-s> <Plug>(coc-snippets-expand)
let g:coc_snippet_next = '<C-u>'
let g:coc_snippet_prev = '<C-z>'

"" Filetypes

augroup MyAutoCmd
  autocmd!
augroup END

autocmd MyAutoCmd FileType go
\   setlocal noexpandtab
\ | setlocal shiftwidth=8
\ | setlocal softtabstop=8

autocmd MyAutoCmd FileType json
\   syntax match Comment +\/\/.\+$+

autocmd MyAutoCmd FileType make
\   setlocal noexpandtab
\ | setlocal shiftwidth=8
\ | setlocal softtabstop=8

autocmd MyAutoCmd BufNewFile,BufRead *.sig
\   set filetype=sml

autocmd MyAutoCmd FileType tex
\   setlocal iskeyword+=:
\ | setlocal iskeyword+=-
