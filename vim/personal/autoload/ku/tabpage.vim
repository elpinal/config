" ku source: tabpage
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
" Variables  "{{{1

let s:cached_items = []








" Interface  "{{{1
function! ku#tabpage#available_sources()  "{{{2
  return ['tabpage']
endfunction




function! ku#tabpage#on_source_enter(source_name_ext)  "{{{2
  " FIXME: better caching
  let _ = []
  for i in range(1, tabpagenr('$'))
    let name = gettabvar(i, 'title')
    let name = name != '' ? name : fnamemodify(gettabvar(i, 'cwd'), ':t')
    let name = name != '' ? name : fnamemodify(getcwd(), ':t')
    call add(_, {
    \      'word': name,
    \      'menu': printf('tabpage %*d', len(tabpagenr('$')), i),
    \      'dup': 1,
    \      'ku_tabpage_nr': i,
    \      'ku__sort_priority': name ==# fnamemodify(name, ':p')
    \    })
  endfor
  let s:cached_items = _
endfunction




function! ku#tabpage#action_table(source_name_ext)  "{{{2
  return {
  \   'default': 'ku#tabpage#action_open',
  \   'delete': 'ku#tabpage#action_delete',
  \   'open!': 'ku#tabpage#action_open_x',
  \   'open': 'ku#tabpage#action_open',
  \ }
endfunction




function! ku#tabpage#key_table(source_name_ext)  "{{{2
  return {
  \   "\<C-o>": 'open',
  \   'D': 'delete',
  \   'O': 'open!',
  \   'o': 'open',
  \ }
endfunction




function! ku#tabpage#gather_items(source_name_ext, pattern)  "{{{2
  return s:cached_items
endfunction




function! ku#tabpage#special_char_p(source_name_ext, character)  "{{{2
  return 0
endfunction








" Misc.  "{{{1
function! s:open(bang, item)  "{{{2
  if a:item.ku__completed_p
    execute a:item.ku_tabpage_nr 'tabnext'.a:bang
  else
    execute 'edit'.a:bang fnameescape(a:item.word)
  endif
  return 0  " FIXME: action: How about the results of the previous commands?
endfunction




function! s:delete(delete_command, item)  "{{{2
  if a:item.ku__completed_p
    execute a:item.ku_tabpage_nr a:delete_command
    return 0
  else
    return 'No such tabpage: ' . string(a:item.word)
  endif
endfunction




" Actions  "{{{2
function! ku#tabpage#action_delete(item)  "{{{3
  return s:delete('tabclose', a:item)
endfunction


function! ku#tabpage#action_open(item)  "{{{3
  return s:open('', a:item)
endfunction


function! ku#tabpage#action_open_x(item)  "{{{3
  return s:open('!', a:item)
endfunction








" __END__  "{{{1
" vim: foldmethod=marker
