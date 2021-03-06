" Vim additional ftplugin: haskell.vim - Haskell
" Version: 0.0.0
" Copyright (C) 2017 El Pin Al
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

if exists("b:did_ftplugin_haskell")
  finish
endif




" alignment
command! -buffer -nargs=? -range Align  <line1>,<line2>call haskell#align#align(<f-args>)

" completion
setlocal omnifunc=haskell#complete#haskell_complete

" open tests
command! -buffer EditTest  call haskell#test#edit()

" jump file
command! -buffer JumpToModule  call haskell#jumpfile#here()




nnoremap <buffer> <silent> <LocalLeader>a  :Align<Return>
vnoremap <buffer> <silent> <LocalLeader>a  :Align<Return>
nnoremap <buffer> <silent> <LocalLeader>s  :<C-u>!stack test --fast --ghc-options="-Wunused-imports -Wincomplete-patterns"<Return>
nnoremap <buffer> <silent> <LocalLeader>t  :<C-u>EditTest<Return>
nnoremap <buffer> <silent> <LocalLeader>j  :<C-u>JumpToModule<Return>




if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '|'
else
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
\   delcommand Align
\ | setlocal omnifunc<
\ | delcommand EditTest
\ | delcommand JumpToModule
\ | execute "silent! nunmap <buffer> <LocalLeader>a"
\ | execute "silent! vunmap <buffer> <LocalLeader>a"
\ | execute "silent! nunmap <buffer> <LocalLeader>s"
\ | execute "silent! nunmap <buffer> <LocalLeader>t"
\ | execute "silent! nunmap <buffer> <LocalLeader>j"
\ | unlet b:did_ftplugin_haskell
\ '

let b:did_ftplugin_haskell = 1

" __END__
" vim: foldmethod=marker
