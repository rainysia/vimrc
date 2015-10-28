" **************************************************************************
" * Copyright (C) 2007-2009 Mitanu Paul
" *
" * All Rights Reserved.
" *
" * This program is distributed in the hope that it will be useful, and is
" * licensed under the Apache License, Version 2.0 (the "License").
" * You may not use this file except in compliance with the License.
" * You may obtain a copy of the License at
" *
" *       http://www.apache.org/licenses/LICENSE-2.0
" *
" * Unless required by applicable law or agreed to in writing, software
" * distributed under the License is distributed on an "AS IS" BASIS,
" * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" * See the License for the specific language governing permissions and
" * limitations under the License.
" **************************************************************************
" vi:sw=2
"
" File: multisearch.vim
" Author: Mitanu Paul
" Description:
"    Add ability to search/highlight multiple search terms
"
" History:
" Version Date     Who  Description
" --------------------------------------------------------------------------
" 0.5     04/22/08 MP   First usable version with multiple buffers
" 0.6     04/24/08 MP   Reuse deleted highlight numbers
" 0.7     10/30/08 MP   Apache license
"                       Fix search wrap message
"         11/03/08 MP   Ability to add a pattern with disabled search
"         12/08/08 MP   Add leaders for mapped key definitions
" 0.8     10/12/09 MP   Ability to customize highlight colors
"         10/23/09 MP   Customize map leaders
"         10/24/09 MP   Created help file
"         10/26/09 MP   Bug fixes - patterns with ' character
" --------------------------------------------------------------------------
"
" TODO:
" Features need more testing:
"    * make it work with vim
"    * ability to add patterns with autocmd
"    * inputsave()/inputrestore() with the use of input()
"
" Possible new features
"    * use the 7.2 matchadd() instead of syntax highlighting
"    * incremental search capability with the add command (needs Vim suport)
"    * integrate with history
"    * show all searches ala :g//p
"    * help [cmd [subcmd] ...]
"    * context sensitive help: e.g., cmd [subcmd] ?
"    * ability to provide labeling
"    * command completion
"    * localization

if exists("s:loaded") || !has('syntax')
  finish
endif

let s:saved_cpo = &cpo
set cpo&vim

silent! unlockvar! s:app
let s:app = 'Msearch'
lockvar s:app

"---------------------------------------------------------------------------
unlockvar! s:usage
let s:usage = [
  \ s:app . ' add [enabled|disabled] [highlight ({key}={arg}...|{groupName})] /{pattern}/',
  \ s:app . '! add [enabled|disabled] [highlight ({key}={arg}...|{groupName})]',
  \ s:app . ' list [{num}[-{num}]... | /{pattern}/]',
  \ s:app . '[!] (enable|disable) [{num}[-{num}]... | /{pattern}/]',
  \ s:app . ' [search] [next|previous] [{num}[-{num}]... | /{pattern}/]',
  \ s:app . '! [search] [next|previous]',
  \ s:app . ' [search] direction [forward|reverse]',
  \ s:app . '! [search] direction',
  \ s:app . ' delete [{num}[-{num}]... | /{pattern}/]',
  \ s:app . '! delete',
  \ '',
  \ s:app . ' highlight add ({key}={arg}... | <groupName>...)',
  \ s:app . '! highlight add [{hnum}[-{hnum}]... | /{hpattern}/]',
  \ s:app . '[!] highlight list [{hnum}[-{hnum}]... | /{hpattern}/]',
  \ s:app . '[!] highlight shuffle',
  \ s:app . ' highlight remove [{hnum}[-{hnum}]... | /{hpattern}/]',
  \ s:app . '! highlight remove',
  \ '',
  \ s:app . ' help',
\ ]
lockvar! s:usage

"---------------------------------------------------------------------------
exec 'command! -nargs=* -bang ' . s:app
  \    . ' call <SID>doMultiSearch(<q-bang>, <q-args>)'

"---------------------------------------------------------------------------
function! s:getLeader(leader)
  return a:leader == '' ? '\' : a:leader
endfunction

"---------------------------------------------------------------------------
unlockvar! s:keymap
let s:keymap = {
  \ 'leader' : exists("g:" . s:app . "_mapleader")
  \   ? s:getLeader(g:{s:app}_mapleader)
  \   : exists("g:mapleader")
  \     ? s:getLeader(g:mapleader)
  \     : '',
  \ 'map' : {
  \   'add' : '<M-/>',
  \   '!add' : '<M-a>',
  \   'list' : '<M-l>',
  \   '!enable' : '<M-q>',
  \   'next' : '<M-n>',
  \   'previous' : '<M-p>',
  \   'search' : '<M-\>',
  \   '!search' : '<M-1>',
  \   '!next' : '<M-Down>',
  \   '!previous' : '<M-Up>',
  \   'direction reverse' : '<M-Left>',
  \   'direction forward' : '<M-Right>',
  \   '!direction' : '<M-6>',
  \   'delete' : '<M-Del>',
  \   'highlight list' : '<M-i>l',
  \   '!highlight list' : '<M-i>L',
  \   'highlight shuffle' : '<M-i>s',
  \   '!highlight shuffle' : '<M-i>S',
  \ },
\ }
"----------------
function! s:keymap.cmd(cmd)
  return s:app . (a:cmd =~ '^!' ? '! ' . a:cmd[1:] : ' ' . a:cmd) . '<Return>'
endfunction
"----------------
function! s:keymap.key(cmd)
  return has_key(self.map, a:cmd)
    \ ? self.leader . self.map[a:cmd]
    \ : ':' . self.cmd(a:cmd)
endfunction
"----------------
function! s:keymap.mapkeys()
  if self.leader != ''
    let leader = '<Leader>'
    if exists("g:mapleader")
      let save_mapleader = g:mapleader
    endif
    let g:mapleader = self.leader
  else
    let leader = ''
  endif

  for item in items(self.map)
    exec 'map <silent> ' . leader . item[1] . ' :<C-U>' . self.cmd(item[0])
  endfor

  if self.leader != ''
    if exists('l:save_mapleader')
      let g:mapleader = save_mapleader
    else
      unlet g:mapleader
    endif
  endif
endfunction
call s:keymap.mapkeys()
unlet s:keymap.mapkeys
lockvar! s:keymap

"---------------------------------------------------------------------------
function! s:SID()
  return matchstr(expand('<sfile>'), '\zs<SNR>\d\+_\zeSID$')
endfunction

"---------------------------------------------------------------------------
function! s:function(name)
  return function(a:name =~ '^s:' ? (s:SID() . a:name[2:]) : a:name)
endfunction

"---------------------------------------------------------------------------
" Convert a list of [key, value] pairs into a dictionary
function! s:toDict(items)
  let dict = {}
  for item in a:items
    let dict[item[0]] = item[1]
  endfor
  return dict
endfunction

"---------------------------------------------------------------------------
function! s:numerically(n1, n2)
  return a:n1 - a:n2
endfunction
silent! unlockvar! s:Numerically
let s:Numerically = s:function('s:numerically')
lockvar! s:Numerically

"---------------------------------------------------------------------------
function! s:doMultiSearch(bang, args)
  try
    call s:commands.invoke(a:bang == '!', 'command', a:args, s:function('s:cmd_Search'))
  catch /^Msearch:/
    call s:error(v:exception)
  endtry
endfunction

"---------------------------------------------------------------------------
function! s:error(msg)
  echohl ErrorMsg
  echo a:msg
  echohl None
endfunction

"---------------------------------------------------------------------------
function! s:warning(msg)
  echohl WarningMsg
  echo a:msg
  echohl None
endfunction

"---------------------------------------------------------------------------
function! s:cmd_Help(ignored, args)
  " TODO: Use args for a more sophisticated help
  call s:cmd_Usage(a:ignored)
endfunction

"---------------------------------------------------------------------------
function! s:cmd_Usage(ignored, ...)
  if a:0 > 0
    let msg = join(a:000)
    call s:error(msg)
    echohl Normal
    echo ''
  endif
  echo 'Usage:'
  let group = s:app . 'Usage'
  if !hlexists(group)
    exec 'highlight ' . group . ' ctermfg=blue guifg=blue'
  endif
  exec 'echohl ' . group
  for items in s:usage
    echo '   ' items
  endfor
  echohl None
endfunction

"---------------------------------------------------------------------------
silent! unlet s:lastPattern
silent! unlockvar! s:addArgsPtrn
silent! unlet! s:addArgsPtrn
function! s:cmd_Add(useSearchReg, ptrn)
  if !exists('s:addArgsPtrn')
    let s:addArgsPtrn =
      \ '^\c\%(\(en\%[abled]\|di\%[sabled]\)\s\+\)\='
      \ . '\%(hi\%[ghlight]\s\+\(\%('
      \    . s:HighlightKeyArgPattern
      \    . '\%(\s\+' . s:HighlightKeyArgPattern . '\)*\)\|\w\+\)\)\='
      \ . '\s*\zs.*\ze$'
    lockvar! s:addArgsPtrn
  endif
  let [ptrn, state, hlArgs; ignored] = matchlist(a:ptrn, s:addArgsPtrn)
  if a:useSearchReg
    if ptrn != ''
      throw s:app . ': Trailing characters after command'
    endif
    let ptrn = @/
  elseif ptrn == ''
    let text =
      \ v:count > 0 && has_key(s:data.idx, v:count)
      \   ? s:data.idx[v:count]
      \   : exists('s:lastPattern') ? s:lastPattern : @/
    call inputsave()
    let inputPtrn = input(':' . s:app . ' add /', text)
    call inputrestore()
    if inputPtrn == ''
      throw s:app . ': No pattern specified'
    endif
    let ptrn = s:getPattern('/' . inputPtrn . '/')
  else
    let ptrn = s:getPattern(ptrn)
  endif
  let s:lastPattern = ptrn
  call s:data.add(state =~ '^\cdi\%[sabled]$' ? 'Disable' : 'Enable',
    \             hlArgs =~ '^\w*$'? hlArgs : s:getHighlightArgs(hlArgs),
    \             ptrn)
endfunction

"---------------------------------------------------------------------------
function! s:cmd_List(bang, args)
  if a:bang
    throw s:app . ': No ! allowed with this command'
  endif
  call s:data.list(s:getNums(a:args))
endfunction

"---------------------------------------------------------------------------
function! s:cmd_Highlight(bang, args)
  call s:commands.invoke(a:bang, 'highlight', a:args, '')
endfunction

"---------------------------------------------------------------------------
function! s:cmd_Search(all, args)
  call s:commands.invoke(a:all, 'search', a:args, s:data.dirFn[s:data.direction])
endfunction

"---------------------------------------------------------------------------
function! s:cmd_Next(all, args)
  call s:doNextPrevious(a:all, a:args, 0)
endfunction

"---------------------------------------------------------------------------
function! s:cmd_Previous(all, args)
  call s:doNextPrevious(a:all, a:args, 1)
endfunction

"---------------------------------------------------------------------------
function! s:doNextPrevious(all, args, isPrevious)
  if a:all
    if a:args != ''
      throw s:app . ': Trailing characters after command'
    endif
    call s:data.search(1, [], a:isPrevious)
  else
    call s:data.search(0, s:getNums(a:args), a:isPrevious)
  endif
endfunction

"---------------------------------------------------------------------------
function! s:cmd_Direction(toggle, args)
  if a:toggle
    call s:doForwardReverse('toggle', a:args)
  else
    call s:commands.invoke('', 'direction', a:args, s:function('s:doForwardReverse'))
  endif
endfunction

"---------------------------------------------------------------------------
function! s:cmd_Forward(ignored, args)
  call s:doForwardReverse('forward', a:args)
endfunction

"---------------------------------------------------------------------------
function! s:cmd_Reverse(ignored, args)
  call s:doForwardReverse('reverse', a:args)
endfunction

"---------------------------------------------------------------------------
function! s:doForwardReverse(type, args)
  if a:args != ''
    throw s:app . ': Trailing characters after command'
  endif
  call s:data.setDirection(a:type)
endfunction

"---------------------------------------------------------------------------
function! s:cmd_Delete(all, args)
  if a:all
    if a:args != ''
      throw s:app . ': Trailing characters after command'
    endif
    call s:data.clear()
  else
    call s:data.delete(s:getNums(a:args))
  endif
endfunction

"---------------------------------------------------------------------------
function! s:cmd_Enable(toggle, args)
  call s:data.state((a:toggle ? 'Toggle' : 'Enable'), s:getNums(a:args), 1)
endfunction

"---------------------------------------------------------------------------
function! s:cmd_Disable(toggle, args)
  return s:data.state((a:toggle ? 'Toggle' : 'Disable'), s:getNums(a:args), 1)
endfunction

unlockvar! s:HighlightKeyArgPattern
" Highlight command's key=arg pattern. Arg can be either a quoted string or
" must not contain a space.
let s:HighlightKeyArgPattern = '\%(\w\+=\%('
    \ . join([
    \     '''\%(''''\|[^'']\)*''',
    \     '"\%(\\.\|[^\"]\)*"',
    \     '\%(\S\+\)'], '\|')
    \ . '\)\)'
lockvar! s:HighlightKeyArgPattern

"---------------------------------------------------------------------------
function! s:cmd_Highlight_Add(builtin, args)
  if a:builtin
    let args = s:getNums(a:args, 'builtin')
  elseif a:args =~ '^\w\+\%(\s\+\w\+\)*\s*$'
    let args = split(a:args, '\s\+')
  else
    let args = [s:getHighlightArgs(a:args)]
  endif
  call s:highlight.data.add(a:builtin, args)
endfunction

"---------------------------------------------------------------------------
function! s:cmd_Highlight_List(builtin, args)
  let list = s:getNums(a:args, a:builtin ? 'builtin' : 'user_defined')
  call s:highlight.data.list(a:builtin, list)
endfunction

"---------------------------------------------------------------------------
function! s:cmd_Highlight_Shuffle(builtin, args)
  if a:args != ''
    throw s:app . ': Trailing characters after command'
  endif
  call s:highlight.data.shuffle(a:builtin)
endfunction

"---------------------------------------------------------------------------
function! s:cmd_Highlight_Remove(all, args)
  if a:all
    if a:args != ''
      throw s:app . ': Trailing characters after command'
    endif
    call s:highlight.data.clear()
  else
    call s:highlight.data.remove(s:getNums(a:args, 'user_defined'))
  endif
endfunction

"---------------------------------------------------------------------------
function! s:getPattern(ptrn)
  " We want to validate a pattern like the built-in match commands, e.g.:
  "
  "	match {group} /pattern/
  "
  " Apparently there is no Vim API to do that. So we are going to
  " use one of the *match commands to validate our pattern.
  "
  let m2args = matcharg(2)
  let lz = &lazyredraw
  let &lazyredraw = 1
  let errMsg = ''
  try
    let group = s:app . 'PatternTest'
    if !hlexists(group)
      exec 'highlight link ' . group . ' Normal'
    endif
    exec '2match ' . group . ' ' .  a:ptrn
  catch /^Vim\%((\a\+)\)\=:E\d\+:/
    let errMsg = matchstr(v:exception, '^Vim\%((\a\+)\)\=:E\d\+:\s*\zs.*\ze$')
  finally
    " Clear the 2match setting and restore any previous settings
    exec '2match'
    let &lazyredraw = lz
    if m2args[0] != '' && m2args[1] != ''
      exec '2match ' . m2args[0] . ' /' . m2args[1] . '/'
    endif
  endtry
  if errMsg != ''
    throw s:app . ': ' . errMsg
  else
    return a:ptrn[1:-2]
  endif
endfunction

"---------------------------------------------------------------------------
function! s:getHighlightArgs(args)
  " We want to validate the key=arg elements to the highlight command
  "
  "	highlight <group> <key>=<arg>...
  "
  " Apparently there is no Vim API to do that. So we are going to
  " use the highlight command itself to validate such input
  "
  let errMsg = ''
  try
    let group = s:app . 'HighlightArgsTest'
    exec 'highlight ' . group . ' ' .  a:args
  catch /^Vim\%((\a\+)\)\=:E\d\+:/
    let errMsg = matchstr(v:exception, '^Vim\%((\a\+)\)\=:E\d\+:\s*\zs.*\ze$')
  finally
    " Clear the highlight settings
    exec 'highlight ' . group . ' NONE'
  endtry
  if errMsg != ''
    throw s:app . ': ' . errMsg
  else
    return a:args
  endif
endfunction

"---------------------------------------------------------------------------
silent! unlockvar! s:ptrnLabel
silent! unlet s:ptrnLabel
function! s:getLabel(args, keyword)
  if !exists('s:ptrnLabel')
    " The following pattern will match one of
    "	identifier
    "	'string'
    "	"string"
    let s:ptrnLabel = '\%('
      \ . join(['\I\i*', '''\%(''''\|[^'']\)*''', '"\%(\\.\|[^\"]\)*"'], '\|')
      \ . '\)'
    lockvar! s:ptrnLabel
  endif
  " let ptrn = '^' . (a:keyword != '' ? s:abbrev(keyword, 
  let list = matchlist(args, '^\zs' . s:ptrnLabel . '\?\ze\s*\(.*\)$')
endfunction

"---------------------------------------------------------------------------
silent! unlockvar! s:numArgsSeqPtrn
silent! unlockvar! s:numArgsTypeSpecs
silent! unlet s:numArgsSeqPtrn
silent! unlet! s:numArgsTypeSpecs
function! s:getNums(args, ...)
  if !exists('s:numArgsSeqPtrn')
    " The following pattern will match only these elements:
    "	num
    "	num-
    "	num-num
    "	-num
    let numArgsPtrn = '\d\+\%(-\%(\d\+\)\?\)\?\|-\%(\d\+\)'
    " We now combine them so that we match a (space separated) sequence
    " of the above patterns
    let s:numArgsSeqPtrn =
      \ '^\s*\zs\%(' . numArgsPtrn . '\)\ze' .
      \ '\(\%(\s\+\%(' . numArgsPtrn . '\)\)*\)\s*$'
    lockvar! s:numArgsSeqPtrn
  endif
  if !exists('s:numArgsTypeSpecs')
    let s:numArgsTypeSpecs = {
      \   'data': s:data,
      \   'user_defined': s:highlight.data.user_defined,
      \   'builtin': s:highlight.data.builtin,
      \ }
    lockvar 1 s:numArgsTypeSpecs
  endif
  let args = a:args
  let numType = a:0 > 0 ? a:1 : 'data'
  if args !~ '\S' && v:count > 0
    return s:getNums(v:count, numType)
  endif
  let list = []
  if args =~ s:numArgsSeqPtrn
    let indices = s:numArgsTypeSpecs[numType].idList()
    let maxNum = max(indices)
    let minNum = min(indices)
    let nums = {}
    while args != ''
      let [seq, args; ignored] = matchlist(args, s:numArgsSeqPtrn)
      let [num1, dash, num2; ignored]  =
	\ matchlist(seq, '^\zs\%(\d\+\)\?\ze\(-\)\?\(\d\+\)\?$')
      let num1 = num1 == '' ? minNum : dash == '' ? num1 : max([num1, minNum])
      let num2 = dash == '' ? num1 : num2 != '' ? min([num2, maxNum]) : maxNum
      if num1 <= num2
	let range = filter(range(num1, num2), '!has_key(nums, v:val)')
	call extend(list, range)
	call extend(nums, s:toDict(map(range, '[v:val, 1]')))
      endif
    endwhile
  elseif args != ''
    let ptrn = s:getPattern(args)
    let list = s:numArgsTypeSpecs[numType].ptrnIds(ptrn)
  endif
  return {'args': a:args, 'list': list}
endfunction

"---------------------------------------------------------------------------
function! s:getNumList(items, default)
  if type(a:items) == type([])
    return empty(a:items) && a:default != '' ? eval(a:default) : a:items
  elseif type(a:items) == type({})
    " Must be a return value from s:getNums
    return a:items.args !~ '\S' && a:default != ''
      \ ? eval(a:default)
      \ : a:items.list
  else
    return [a:items]
  endif
endfunction

"---------------------------------------------------------------------------
function! s:doAllBufs(cmd, bufs)
  let cmds = type(a:cmd) == type([]) ? a:cmd : [a:cmd]
  let bufs =
    \ type(a:bufs) == type([]) ? a:bufs : 
    \   a:bufs != ''
    \     ? [a:bufs]
    \     : filter(range(1, bufnr('$')), 'bufwinnr(v:val) >= 0')
  let current = bufnr('%')
  let lz_save = &lazyredraw
  let ei_save = &eventignore
  let &lazyredraw = 1
  let eventignore = 'all'
  for i in bufs
    call s:doOneBuf(i, cmds)
  endfor
  exec 'buffer ' . current
  let &lazyredraw = lz_save
  let &eventignore = ei_save
endfunction

"---------------------------------------------------------------------------
function! s:doOneBuf(bufn, cmds)
  exec 'buffer ' . a:bufn
  try
    for cmd in a:cmds
      exec cmd
    endfor
  catch
    call s:error("Buffer: " . a:bufn . ": " . v:exception)
  endtry
endfunction

"---------------------------------------------------------------------------
function! s:escape(what)
  return substitute(a:what, '[^0-9a-zA-Z_]', '\\\0', 'g')
endfunction

"---------------------------------------------------------------------------
function! s:truncate(what, limit)
  if len(a:what) > a:limit
    return a:what[0 : a:limit-1] . '...'
  else
    return a:what
  endif
endfunction

"---------------------------------------------------------------------------
" Creates a pattern that will match all abbreviations of a given {word}.
" The shortest acceptable abbreviation is specified by {abbrev}.
"
" We will assume that {word} and {abbrev} are alphanumeric
function! s:abbrev(word, abbrev, ic)
  " Characters to be escaped to form atoms. Note that, as of the 7.1 release,
  " the ] character cannot be escaped within \%[]
  let echars = '\^$.~[*]'
  let ic = a:ic ? '\c' : ''
  let ptrn = '^' . ic . escape(a:abbrev, echars)
  if a:word =~ ptrn
    let ptrn .=
      \ len(a:abbrev) < len(a:word)
      \   ? ('\%[' . escape(a:word[len(a:abbrev):], echars) . ']$')
      \   : '$'
  else
    " {abbrev} is not an initial string of {word}. The pattern will match
    " either the {word} or the {abbrev}.
    let ptrn =
      \ '^' . ic .
      \ '\%(' . escape(a:word, echars) . '\|' . escape(a:abbrev, echars) . '\)$'
  endif
    return ptrn
endfunction

"---------------------------------------------------------------------------
silent! unlockvar! s:commands
let s:commands = {
  \ 'command': {
  \   'help': {
  \     'fn': s:function('s:cmd_Help'),
  \     'abbrev': 'he',
  \   },
  \   'add': s:function('s:cmd_Add'),
  \   'list': s:function('s:cmd_List'),
  \   'highlight': {
  \     'fn': s:function('s:cmd_Highlight'),
  \     'abbrev': 'hi',
  \   },
  \   'search': s:function('s:cmd_Search'),
  \   'enable': s:function('s:cmd_Enable'),
  \   'disable': {
  \     'fn': s:function('s:cmd_Disable'),
  \     'abbrev': 'di',
  \   },
  \   'next': s:function('s:cmd_Next'),
  \   'previous': s:function('s:cmd_Previous'),
  \   'direction': {
  \     'fn': s:function('s:cmd_Direction'),
  \     'abbrev': 'dir',
  \   },
  \   'delete': {
  \     'fn': s:function('s:cmd_Delete'),
  \     'abbrev': 'del',
  \   },
  \ },
  \ 'highlight': {
  \   'add': s:function('s:cmd_Highlight_Add'),
  \   'list': s:function('s:cmd_Highlight_List'),
  \   'shuffle': s:function('s:cmd_Highlight_Shuffle'),
  \   'remove': s:function('s:cmd_Highlight_Remove'),
  \ },
  \ 'direction': {
  \   'forward': s:function('s:cmd_Forward'),
  \   'reverse': s:function('s:cmd_Reverse'),
  \ },
  \ 'search': {
  \   'next': ['command', 'next'],
  \   'previous': ['command', 'previous'],
  \   'direction': ['command', 'direction'],
  \ },
  \ 'undefined': s:function('s:cmd_Usage'),
\ }
function! s:commands.update()
  let aliases = []
  for cmd in filter(keys(self), 'type(self[v:val]) == type({})')
    let cmditem = self[cmd]
    for key in keys(cmditem)
      if type(cmditem[key]) == type(function('tr'))
	let item = {'fn': cmditem[key]}
	unlet cmditem[key]
	let cmditem[key] = item
      elseif type(cmditem[key]) == type([])
	call add(aliases, [cmditem, key])
	continue
      else
	let item = cmditem[key]
      endif
      let item.abbrPtrn =
	\ s:abbrev(key, has_key(item, 'abbrev') ? item.abbrev : key[0], 1)
    endfor
  endfor
  unlet item
  for [cmditem, key] in aliases
    let item = self
    for key in cmditem[key]
      let item = item[key]
    endfor
    unlet cmditem[key]
    let cmditem[key] = item
  endfor
endfunction
call s:commands.update()
unlet s:commands.update
"----------------
function! s:commands.invoke(bang, what, args, defaultCmd)
  " extract the {cmd} and {args} parts
  let arglist = matchlist(a:args, '^\s*\zs\w\+\ze\%(\s\+\(.*\)\)\?$')
  if empty(arglist)
    if type(a:defaultCmd) == type(function('tr'))
      let Cmd = a:defaultCmd
      let args = a:args
    else
      let Cmd = self.undefined
      let args = 'No ' . a:what . ' specified: ' . a:args
    endif
  else
    let [match, args; ignored] = arglist
    let matching = filter(copy(self[a:what]), 'match =~ v:val.abbrPtrn')
    let [Cmd, args] =
	\ len(matching) > 1
	\   ? [self.undefined, 'Ambiguous ' . a:what . ': ' . match]
	\   : !empty(matching)
	\     ? [values(matching)[0].fn, substitute(args, '\s\+$', '', '')]
	\     : type(a:defaultCmd) == type(function('tr'))
	\       ? [a:defaultCmd, substitute(a:args, '^\s\+\|\s\+$', '', 'g')]
	\       : [self.undefined, 'Unknown ' . a:what . ': ' . match]
  endif
  call Cmd(a:bang, args)
endfunction
lockvar! s:commands

"---------------------------------------------------------------------------
" Highlight data
function! s:labelHighlight(id) dict
  return
    \ (self.index == a:id ? '*' : ' ')
    \ . printf('%4d', a:id) . ' '
    \ . s:truncate(self.args[a:id], 60)
endfunction
"----------------
let s:highlight = {
  \ 'num': 0,
  \ 'name': {},
  \ 'available': {},
  \ 'data': {
  \   'user_defined': {
  \	'num': 0,
  \     'index': 1,
  \     'args': {},
  \     'menuLabel': s:function('s:labelHighlight'),
  \   },
  \   'builtin': {
  \     'index': 1,
  \     'menuLabel': s:function('s:labelHighlight'),
  \     'args': [
  \       '',
  \       'guibg=orange term=bold',
  \       'guibg=green ctermbg=green term=bold',
  \       'guibg=cyan ctermbg=cyan term=bold',
  \       'guibg=magenta ctermbg=magenta term=bold',
  \       'guibg=blue guifg=white ctermbg=blue ctermfg=white term=inverse',
  \       'guibg=violet term=bold',
  \       'guibg=purple term=bold',
  \       'guibg=gray term=bold',
  \       'guibg=lightyellow ctermbg=lightyellow term=bold',
  \       'guibg=lightred ctermbg=lightred term=bold',
  \       'guibg=lightgreen ctermbg=lightgreen term=bold',
  \       'guibg=lightcyan ctermbg=lightcyan term=bold',
  \       'guibg=lightmagenta ctermbg=lightmagenta term=bold',
  \       'guibg=lightgray ctermbg=lightgray term=bold',
  \       'guibg=slateblue guifg=white term=inverse',
  \       'guibg=darkyellow term=bold',
  \       'guibg=brown guifg=white ctermbg=brown ctermfg=white term=bold',
  \       'guibg=darkcyan term=bold',
  \       'guibg=darkgreen guifg=white ctermbg=darkgreen ctermfg=white term=inverse',
  \       'guibg=darkmagenta guifg=white ctermbg=darkmagenta ctermfg=white term=inverse',
  \       'guibg=darkblue guifg=white term=inverse',
  \       'guibg=darkred guifg=white ctermbg=darkred ctermfg=white term=inverse',
  \       'guibg=yellow ctermbg=yellow term=bold',
  \     ],
  \   },
  \ },
\ }
function! s:highlight.next(hlArgs)
  let num = min(keys(self.available))
  if num > 0
    call remove(self.available, num)
  else
    let self.num += 1
    let num = self.num
  endif
  let self.name[num] = 'MultiSearch' . num
  exec 'highlight ' . self.name[num] . ' NONE'
  exec self.data.command(a:hlArgs, self.name[num])
  return {'id': num, 'hlname': self.name[num]}
endfunction
"----------------
function! s:highlight.recycle(nums)
  let nums = type(a:nums) == type([]) ? a:nums : [a:nums]
  for i in filter(nums, 'has_key(self.name, v:val)')
    let self.available[i] = 0
  endfor
endfunction
"----------------
function! s:highlight.data.command(args, name)
  let args = a:args
  if args == ''
    let items =
      \ len(self.user_defined.args) > 0 ? self.user_defined : self.builtin
    let args = l:items.nextArg()
  endif
  return
    \ 'highlight ' . (args =~ '^\w\+$' ? 'link ' : '') . a:name . ' ' . args
endfunction
"----------------
function! s:highlight.data.builtin.nextArg()
  let arg = self.args[self.index]
  let self.index = self.index % (len(self.args) - 1) + 1
  return arg
endfunction
"----------------
function! s:highlight.data.builtin.idList()
  return range(1, len(self.args) - 1)
endfunction
"----------------
function! s:highlight.data.builtin.ptrnIds(ptrn)
  return filter(self.idList(), 'self.args[v:val] =~ a:ptrn')
endfunction
"----------------
function! s:highlight.data.user_defined.nextArg()
  let arg = self.args[self.index]
  let self.index = self.nextIndex(1)
  return arg
endfunction
"----------------
function! s:highlight.data.user_defined.nextIndex(incr)
  let next = self.index + a:incr
  return max([
    \  min(filter(keys(self.args), 'v:val < l:next')),
    \  min(filter(keys(self.args), 'v:val >= l:next'))])
endfunction
"----------------
function! s:highlight.data.user_defined.idList()
  return sort(keys(self.args), s:Numerically)
endfunction
"----------------
function! s:highlight.data.user_defined.ptrnIds(ptrn)
  return filter(self.idList(), 'self.args[v:val] =~ a:ptrn')
endfunction
"----------------
function! s:highlight.data.user_defined.add(args)
  for arg in a:args
    let self.num += 1
    let self.args[self.num] = arg
  endfor
  let self.index = self.nextIndex(0)
  call s:menu.build()
endfunction
"----------------
function! s:highlight.data.user_defined.clear()
  let self.args = {}
  let self.index = 1
  call s:menu.build()
endfunction
"----------------
function! s:highlight.data.user_defined.remove(items)
  for i in filter(s:getNumList(copy(a:items), ''), 'has_key(self.args, v:val)')
    call remove(self.args, i)
  endfor
  let self.index = self.nextIndex(0)
  call s:menu.build()
endfunction
"----------------
function! s:highlight.data.add(builtin, args)
  let args = a:builtin
    \ ?  map(s:getNumList(a:args, 's:highlight.data.builtin.idList()'),
    \        'self.builtin.args[v:val]')
    \ : a:args
  call self.user_defined.add(args)
endfunction
"----------------
function! s:highlight.data.list(builtin, items)
  let item = a:builtin ? self.builtin : self.user_defined
  let indices = s:getNumList(a:items, '')
  let hlName = s:app . 'HighlightList'
  for i in (len(indices) > 0 ? indices : item.idList())
    if a:builtin ? (i > 0 && i < len(item.args)) :  has_key(item.args, i)
      exec self.command(item.args[i], hlName)
      let h = item.index == i ? '*' : ' '
      echo h printf('%4d ', i)
      exec 'echohl ' . hlName
      echon 'xxxx'
      echohl None
      echon ' ' item.args[i]
      exec 'highlight ' . hlName . ' NONE'
    endif
  endfor
endfunction
"----------------
function! s:highlight.data.clear()
  call self.user_defined.clear()
endfunction
"----------------
function! s:highlight.data.remove(items)
  call self.user_defined.remove(a:items)
endfunction
"----------------
function! s:highlight.data.shuffle(builtin)
  " Shuffle the highlight data entries.
  "
  " Ideally should use the O(n) Knuth shuffle or Fisher-Yates shuffle.
  " Since Vim does not provide a random number generator, Mongean shuffle
  " is used here. The list is cut at a point determined by the current time
  " before carrying out the shuffle in order to prevent the Mongean shuffle
  " from repeating a sequence too often.
  let item = a:builtin ? self.builtin : self.user_defined
  let oldIndices = item.idList()
  let size = len(oldIndices)
  if size < 2
    return
  endif
  let newIndices = []
  let i = localtime() % size
  for l:count in range(1, size)
    call insert(newIndices, oldIndices[i], l:count % 2 - 1)
    let i = (i + 1) % size
  endfor
  let args = copy(item.args)
  for i in range(0, len(oldIndices) - 1)
    let args[oldIndices[i]] = item.args[newIndices[i]]
  endfor
  let item.args = args
  call s:menu.build()
endfunction

"---------------------------------------------------------------------------
" The multi-search data
if exists('s:data') && has_key(s:data, 'clear')
  call s:data.clear()
endif
let s:data = {
  \ 'ptrn': {},
  \ 'idx': {},
  \ 'direction': 'forward',
  \ 'dirFn': {
  \   'forward': s:function('s:cmd_Next'),
  \   'reverse': s:function('s:cmd_Previous'),
  \ },
\ }
"----------------
function! s:data.add(state, hlArgs, ptrn)
  if a:ptrn == ''
    throw s:app . ': Cannot add empty pattern'
  endif
  if has_key(self.ptrn, a:ptrn)
    return
  endif
  let data = s:highlight.next(a:hlArgs)
  let data.ptrn = a:ptrn
  let data.enabled = -1
  for i in ['Enable', 'Disable', 'Toggle', 'Refresh']
    let data[i] = s:function('s:State' . i)
  endfor
  let data.syntaxCmdList = [
    \ 'syntax clear ' . data.hlname,
    \ 'syntax match ' . data.hlname . ' /' . a:ptrn . '/ containedin=ALL',
  \ ]
  let data.syntaxCmd = s:function('s:syntaxCmd')

  let self.idx[data.id] = data
  let self.ptrn[a:ptrn] = data.id

  " Set highlight (and recreate menu items)
  let state = substitute(a:state, '^\(\w\)\(\w*\)$', '\u\1\L\2\E', '')
  call self.state(state == '' ? 'Enable' : state, data.id, 1)
endfunction
"----------------
function! s:data.list(items)
  let items = s:getNumList(a:items, 's:data.idList()')
  for i in items
    if has_key(self.idx, i)
      let data = self.idx[i]
      let h = data.enabled ? '+' : '-'
      echo h printf('%4d ', data.id)
      exec 'echohl ' . data.hlname
      echon data.ptrn
      echohl None
    endif
  endfor
endfunction
"----------------
function! s:data.search(all, items, backwards)
  let default =
    \ 'sort(filter(keys(s:data.idx), '
    \ . (a:all ? '1' : "'s:data.idx[v:val].enabled'")
    \ . '))'
  let items = s:getNumList(copy(a:items), default)
  call filter(items, 'has_key(self.idx, v:val)')
  call map(items, 'self.idx[v:val].ptrn')
  if empty(items)
    throw s:app . ': Nothing to search'
  else
    echo ''
    let ptrn = '\%(' . join(items, '\|') . '\)'
    let [lnum, cnum] = searchpos(ptrn, 's' . (a:backwards ? 'b' : ''))
    if [lnum, cnum] == [0, 0]
      call s:error('Search pattern not found!')
    else
      let cline = line("''")
      if a:backwards
	if lnum > cline || lnum == cline && cnum >= col("''")
	  call s:warning('Search hit TOP, continuing at BOTTOM')
	endif
      elseif lnum < cline || lnum == cline && cnum <= col("''")
	call s:warning('Search hit BOTTOM, continuing at TOP')
      endif
    endif
  endif
endfunction
"----------------
function! s:data.state(fn, items, buildMenu)
  let items = s:getNumList(copy(a:items), '')
  let cmdlist = []
  for i in filter(items, 'has_key(self.idx, v:val)')
    let data = self.idx[i]
    let old = data.enabled
    if old != data[a:fn]()
      call add(cmdlist, data.syntaxCmd())
    else
    endif
  endfor
  if !empty(cmdlist)
    call s:doAllBufs(cmdlist, '')
    if a:buildMenu
      call s:menu.build()
    endif
  endif
endfunction
"----------------
function! s:data.setDirection(type)
  if has_key(self.dirFn, a:type)
    let self.direction = a:type
  elseif a:type == 'toggle'
    let self.direction = filter(keys(self.dirFn), 'v:val != self.direction')[0]
  elseif a:type != ''
    throw s:app . ': unknown direction: ' . a:type
  endif
  echon s:app ': direction: ' . self.direction
endfunction
"----------------
function! s:data.clear()
  call self.state('Disable', keys(self.idx), 0)
  call s:highlight.recycle(keys(self.idx))
  let self.idx = {}
  let self.ptrn = {}
  if exists('s:menu')
    call s:menu.build()
  endif
endfunction
"----------------
function! s:data.delete(items)
  let items = s:getNumList(copy(a:items), '')
  call filter(items, 'has_key(self.idx, v:val)')
  call self.state('Disable', items, 0)
  for i in items
    call remove(self.ptrn, self.idx[i].ptrn)
    call remove(self.idx, i)
  endfor
  call s:highlight.recycle(items)
  call s:menu.build()
endfunction
"----------------
function! s:data.update(buf)
  call s:doAllBufs(map(values(self.idx), 'v:val.syntaxCmd()'), bufnr('%'))
endfunction
"----------------
function! s:data.idList()
  return sort(keys(self.idx), s:Numerically)
endfunction
"----------------
function! s:data.ptrnIds(ptrn)
  return filter(self.idList(), 'self.idx[v:val].ptrn =~ a:ptrn')
endfunction
"----------------
function! s:data.menuLabel(id)
  let data = self.idx[a:id]
  return
    \ (data.enabled ? '+' : '-')
    \ . printf('%4d ', data.id)
    \ . s:truncate(data.ptrn, 40)
endfunction

"---------------------------------------------------------------------------
" Dict functions for s:data.idx data
function! s:StateEnable() dict
  let self.enabled = 1
  return self.enabled
endfunction

function! s:StateDisable() dict
  let self.enabled = 0
  return self.enabled
endfunction

function! s:StateToggle() dict
  let self.enabled = !self.enabled
  return self.enabled
endfunction

function! s:StateRefresh() dict
  " This will force refresh
  return !self.enabled
endfunction

function! s:syntaxCmd() dict
  return self.syntaxCmdList[self.enabled]
endfunction

"---------------------------------------------------------------------------
" Menu building functions
"---------------------------------------------------------------------------
function! s:setMenuItems()
  let list = [s:menu]
  while !empty(list)
    let item = remove(list, 0)
    let item.getItems = s:function('s:getMenuItems')
    if has_key(item, 'sub')
      if type(item.sub) == type(function('tr'))
	if has_key(item, 'menuizer') && has_key(item.menuizer, 'preset')
	  let preset = item.menuizer.preset
	  call extend(list, (type(preset) == type([]) ? preset : [preset]))
	  unlet preset
	endif
      else
	let sublist = type(item.sub) == type([])
	  \ ? item.sub
	  \ : type(item.sub) == type({}) ? values(item.sub) : [item.sub]
	call extend(list, sublist)
	unlet sublist
      endif
    endif
  endwhile
endfunction

"---------------------------------------------------------------------------
function! s:getMenuItems(plevel, pname) dict
  let level = a:plevel . self.level
  let shortcutIndex = has_key(self, '&') ? match(self.name, self['&']) : -1
  let id = shortcutIndex > 0
    \ ? s:escape(self.name[0 : shortcutIndex-1])
    \     . '&' . s:escape(self.name[shortcutIndex :])
    \ : (shortcutIndex == 0 ? '&' : '') . s:escape(self.name)
  let name = a:pname . id
  if has_key(self, 'sub')
    let subitems =
      \ type(self.sub) == type(function('tr')) ? self.sub() : self.sub
    let subitemlist =
      \ type(subitems) == type({}) ? values(subitems) :
      \ type(subitems) != type([]) ? [subitems] : subitems
    let level .= '.'
    let name .= '.'
    let list = []
    for sub in subitemlist
      call extend(list, sub.getItems(level, name))
    endfor
    return list
  else
    let elem = 'menu <silent> ' . level . ' ' . name
    let cmd = !has_key(self, 'cmd') ? ':'
      \ : type(self.cmd) == type(function('tr')) ? self.cmd() : self.cmd
    if has_key(self, 'tab')
      let elem .= '<Tab>' . self.tab
    elseif cmd != ':' && cmd != ':<Return>'
      let elem .= '<Tab>' . s:escape(cmd)
    endif
    let elem .= ' ' . cmd
    return [{'key': name, 'cmd':elem}]
  endif
endfunction

"---------------------------------------------------------------------------
function! s:menuize(menuItem, data)
  let menuizer = has_key(a:menuItem, 'menuizer') ? a:menuItem.menuizer : {}
  let preset_val = has_key(menuizer, 'preset') ? menuizer.preset : []
  let preset = type(preset_val) == type([]) ? preset_val : [preset_val]
  let levelPrefix =
    \ has_key(menuizer, 'levelPrefix') ? menuizer.levelPrefix : 1
  let list = copy(preset)
  for id in a:data.idList()
    let cmd = id . menuizer.cmd
    let menuData = {
      \ 'name': a:data.menuLabel(id),
      \ 'level': levelPrefix . id,
      \ 'cmd': cmd,
      \ 'getItems': s:function('s:getMenuItems'),
    \ }
    call add(list, menuData)
  endfor
  return list
endfunction

"---------------------------------------------------------------------------
function! s:menuizeData() dict
  return s:menuize(self, s:data)
endfunction

"---------------------------------------------------------------------------
function! s:menuizeHighlightUserDefined() dict
  return s:menuize(self, s:highlight.data.user_defined)
endfunction

"---------------------------------------------------------------------------
function! s:menuizeHighlightBuiltin() dict
  return s:menuize(self, s:highlight.data.builtin)
endfunction

"---------------------------------------------------------------------------
silent! unlockvar! s:menu
let s:menu = {
  \ 'name': 'Multi Search',
  \ 'level': 100,
  \ '&': 'M',
  \ 'sub': [
  \   {
  \     'name': 'List',
  \     '&': 'L',
  \     'level': 5,
  \     'sub': s:function('s:menuizeData'),
  \     'menuizer': {
  \       'preset': [
  \         {
  \           'name': 'List',
  \           'level': 1,
  \           'cmd': ':<Return>'
  \         },
  \         {
  \           'name': '-sep1-',
  \           'level': 2,
  \         },
  \         {
  \           'name': 'All',
  \           '&': 'A',
  \           'level': 3,
  \           'cmd': s:keymap.key('list'),
  \         },
  \         {
  \           'name': '-sep2-',
  \           'level': 4,
  \         },
  \       ],
  \       'levelPrefix': 10,
  \       'cmd': s:keymap.key('list'),
  \     },
  \   },
  \   {
  \     'name': 'Search',
  \     '&': 'S',
  \     'level': 10,
  \     'sub': s:function('s:menuizeData'),
  \     'menuizer': {
  \       'preset': [
  \         {
  \           'name': 'Search',
  \           'level': 1,
  \           'cmd': ':<Return>',
  \         },
  \         {
  \           'name': '-sep1-',
  \           'level': 2,
  \         },
  \         {
  \           'name': 'All',
  \           '&': 'A',
  \           'level': 3,
  \           'cmd': s:keymap.key('!search'),
  \         },
  \         {
  \           'name': 'Enabled Only',
  \           '&': 'H',
  \           'level': 4,
  \           'cmd': s:keymap.key('search'),
  \         },
  \         {
  \           'name': 'Search Forward',
  \           '&': 'F',
  \           'level': 5,
  \           'cmd': s:keymap.key('direction forward'),
  \         },
  \         {
  \           'name': 'Search Backward',
  \           '&': 'B',
  \           'level': 6,
  \           'cmd': s:keymap.key('direction reverse'),
  \         },
  \         {
  \           'name': '-sep2-',
  \           'level': 7,
  \         },
  \       ],
  \       'levelPrefix': 10,
  \       'cmd': s:keymap.key('search'),
  \     },
  \   },
  \   {
  \     'name': 'Enable/Disable',
  \     '&': 'E',
  \     'level': 20,
  \     'sub': s:function('s:menuizeData'),
  \     'menuizer': {
  \       'preset': [
  \         {
  \           'name': 'Enable/Disable',
  \           'level': 1,
  \           'cmd': ':<Return>',
  \         },
  \         {
  \           'name': '-sep1-',
  \           'level': 2,
  \         },
  \       ],
  \       'levelPrefix': 10,
  \       'cmd': s:keymap.key('!enable'),
  \     },
  \   },
  \   {
  \     'name': 'Add',
  \     '&': 'A',
  \     'level': 30,
  \     'sub': [
  \         {
  \           'name': 'Add',
  \           'level': 1,
  \           'cmd': ':<Return>',
  \         },
  \         {
  \           'name': '-sep1-',
  \           'level': 2,
  \         },
  \       {
  \         'name': 'From Search',
  \         '&': 'S',
  \         'level': 10,
  \         'cmd': s:keymap.key('!add'),
  \       },
  \       {
  \         'name': 'Pattern',
  \         '&': 'P',
  \         'level': 20,
  \         'cmd': s:keymap.key('add'),
  \       },
  \     ],
  \   },
  \   {
  \     'name': 'Delete',
  \     'level':40,
  \     'sub': s:function('s:menuizeData'),
  \     'menuizer': {
  \       'preset': [
  \         {
  \           'name': 'Delete',
  \           'level': 1,
  \           'cmd': ':<Return>',
  \         },
  \         {
  \           'name': '-sep1-',
  \           'level': 2,
  \         },
  \         {
  \           'name': 'All',
  \           'level': 3,
  \           'cmd': s:keymap.key('!delete'),
  \         },
  \         {
  \           'name': '-sep2-',
  \           'level': 4,
  \         },
  \       ],
  \       'levelPrefix': 10,
  \       'cmd': s:keymap.key('delete'),
  \     },
  \   },
  \   {
  \     'name': 'Highlight',
  \     'level':50,
  \     'sub': [
  \       {
  \         'name': 'Builtin',
  \         'level': 1,
  \         'sub': s:function('s:menuizeHighlightBuiltin'),
  \         'menuizer': {
  \           'preset': [
  \             {
  \               'name': 'Shuffle',
  \               'level': 1,
  \               'cmd': s:keymap.key('!highlight shuffle'),
  \             },
  \             {
  \               'name': '-sep1-',
  \               'level': 5,
  \             },
  \             {
  \               'name': 'List all',
  \               'level': 10,
  \               'cmd': s:keymap.key('!highlight list'),
  \             },
  \             {
  \               'name': '-sep2-',
  \               'level': 15,
  \             },
  \           ],
  \           'levelPrefix': 10,
  \           'cmd': s:keymap.key('!highlight list'),
  \         },
  \       },
  \       {
  \         'name': 'User Defined',
  \         'level': 2,
  \         'sub': s:function('s:menuizeHighlightUserDefined'),
  \         'menuizer': {
  \           'preset': [
  \             {
  \               'name': 'Shuffle',
  \               'level': 1,
  \               'cmd': s:keymap.key('highlight shuffle'),
  \             },
  \             {
  \               'name': '-sep1-',
  \               'level': 5,
  \             },
  \             {
  \               'name': 'List all',
  \               'level': 10,
  \               'cmd': s:keymap.key('highlight list'),
  \             },
  \             {
  \               'name': '-sep2-',
  \               'level': 15,
  \             },
  \           ],
  \           'levelPrefix': 10,
  \           'cmd': s:keymap.key('highlight list'),
  \         },
  \       },
  \     ],
  \   },
  \ ],
\ }
"----------------
function! s:menu.remove(items)
  for item in a:items
    exec 'silent unmenu ' . item
  endfor
endfunction
"----------------
if exists('s:current_menus')
  call s:menu.remove(keys(s:current_menus))
  unlet s:current_menus
endif
"----------------
function! s:menu.build()
  if !exists('s:current_menus')
    let s:current_menus = {}
  endif

  let newMenus = s:menu.getItems('', '')
  " Remove the deleted menu items
  let lz = &lazyredraw
  let &lazyredraw = 1
  let menuKeys = s:toDict(map(copy(newMenus), '[v:val.key, 1]'))
  call self.remove(filter(keys(s:current_menus), '!has_key(menuKeys, v:val)'))

  " Add/Modify the new menu items
  let s:current_menus = {}
  unlet! item
  for item in filter(newMenus, '!has_key(s:current_menus, v:val.key) || v:val.cmd != s:current_menus[v:val.key]')
    exec 'silent ' . item.cmd
    let s:current_menus[item.key] = item.cmd
  endfor
  let &lazyredraw = lz
endfunction
call s:setMenuItems()
lockvar! s:menu

"au VimEnter * call s:menu.build()
au GuiEnter * call s:menu.build()
au BufWinEnter * call s:data.update(bufnr('%'))

let s:in_development = 0
if s:in_development
  call s:menu.build()
else
  let s:loaded = 0
endif
let &cpo = s:saved_cpo
