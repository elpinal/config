" Vim additional ftplugin: complete.vim - completion
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

let s:keywords = [
  \ 'case',
  \ 'class',
  \ 'data',
  \ 'default',
  \ 'deriving',
  \ 'do',
  \ 'else',
  \ 'foreign',
  \ 'if',
  \ 'import',
  \ 'in',
  \ 'infix',
  \ 'infixl',
  \ 'infixr',
  \ 'instance',
  \ 'let',
  \ 'module',
  \ 'newtype',
  \ 'of',
  \ 'then',
  \ 'type',
  \ 'where',
  \ '_'
  \ ]

function! HaskellComplete(findstart, base)
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start
  else
    let res = []
    for k in s:keywords
      if k =~ '^' . a:base
        call add(res, k)
      endif
    endfor
    return res
  endif
endfunction

setlocal omnifunc=HaskellComplete

let b:undo_ftplugin .= (exists('b:undo_ftplugin') ? ' | ' : '') . 'setlocal omnifunc<'

" __END__
" vim: foldmethod=marker
