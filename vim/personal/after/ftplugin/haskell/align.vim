" Vim additional ftplugin: align.vim - align `shouleBe` for testing with Hspec of Haskell.
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

if exists("b:did_ftplugin_haskell_align")
    finish
endif

let s:query = '`shouldBe`'

function! s:get_col()
  let [_, _, col, _] = getpos('.')
  return col
endfunction

function! s:add_col()
  normal! n
  let col = s:get_col()
  let s:cols += [col]
endfunction

function! s:get_max_col(f, l)
  let s:cols = []
  execute a:f ',' a:l 'g/' . s:query . '/call s:add_col()'
  return max(s:cols)
endfunction

function! s:pack_spaces(c0)
  normal! n
  let col = s:get_col()
  let spaces = repeat(' ', a:c0 - col)
  execute 'normal!' 'i' . spaces
endfunction

function! s:align() range
  let col = s:get_max_col(a:firstline, a:lastline)
  execute a:firstline ',' a:lastline 'g/' . s:query . '/call s:pack_spaces(' . col . ')'
endfunction

command! -buffer -range Align  <line1>,<line2>call s:align()

let b:undo_ftplugin .= (b:undo_ftplugin == '' ? '' : ' | ') . 'delcommand Align'

let b:did_ftplugin_haskell_align = 1

" __END__
" vim: foldmethod=marker
