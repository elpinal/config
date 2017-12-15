" Vim ftplugin: xxd - Edit binaries
" Version: 0.0.0
" Original: <http://vim-jp.org/vim-users-jp/2010/03/21/Hack-133.html>
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

if exists('b:did_ftplugin')
  finish
endif

if !executable('xxd')
  finish
endif








function! s:xxd() abort
  setlocal binary
  setlocal noendofline
  silent %!xxd -g 1
  %s/\r$//e
  setlocal nomodified
endfunction

function! s:pre_save()
  let b:xxd_cursor = getpos('.')
  silent %!xxd -r
endfunction

function! s:post_save()
  silent %!xxd -g 1
  %s/\r$//e
  setlocal nomodified
  call setpos('.', b:xxd_cursor)
  unlet b:xxd_cursor
endfunction

call s:xxd()
augroup ftplugin-xxd
  autocmd! * <buffer>
  autocmd BufWritePre <buffer> call s:pre_save()
  autocmd BufWritePost <buffer> call s:post_save()
augroup END








let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin . ' | ' : '')
\ . 'setlocal bin< eol< | execute "autocmd! ftplugin-xxd * <buffer>" | execute "silent %!xxd -r"'

let b:did_ftplugin = 1

" __END__
" vim: foldmethod=marker
