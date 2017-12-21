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
command! -buffer -range Align  <line1>,<line2>call haskell#align#align()

" completion
setlocal omnifunc=haskell#complete#haskell_complete

" open tests
command! -buffer EditTest  call s:edit_test()
function! s:edit_test()
  let _ = matchlist(expand('%'), '\v<src\/(.*\.hs)')
  if len(_) == 0
    return
  endif
  execute 'edit' 'test/' . _[1]
endfunction




if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '|'
else
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
\   delcommand Align
\ | setlocal omnifunc<
\ | delcommand EditTest
\ '

let b:did_ftplugin_haskell = 1

" __END__
" vim: foldmethod=marker
