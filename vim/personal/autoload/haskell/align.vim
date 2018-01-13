" align.vim - align infix notations for testing with Hspec of Haskell.
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
" Variables "{{{1
let s:query = '`shouldBe`'








" Interface  "{{{1
function! s:jump_to_match()
  execute "normal! /\<CR>"
endfunction

function! s:add_col()
  call s:jump_to_match()
  let s:cols += [col('.')]
endfunction

function! s:get_max_col(f, l, query)
  let s:cols = []
  execute a:f ',' a:l 'g/' . a:query . '/call s:add_col()'
  return max(s:cols)
endfunction

function! s:pack_spaces(c0)
  call s:jump_to_match()
  let spaces = repeat(' ', a:c0 - col('.'))
  execute 'normal!' 'i' . spaces
endfunction

function! haskell#align#align(...) range
  let query = s:query
  if a:0 == 1
    let query = a:1
  endif
  let col = s:get_max_col(a:firstline, a:lastline, query)
  execute a:firstline ',' a:lastline 'g/' . query . '/call s:pack_spaces(' . col . ')'
endfunction








" Misc.  "{{{1








" __END__  "{{{1
" vim: foldmethod=marker
