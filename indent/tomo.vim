" Language:    Tomo
" Maintainer:  Bruce Hill <bruce@bruce-hill.com>
" License:     WTFPL

if exists("b:did_indent")
  finish
endif

let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=GetTomoIndent()
setlocal indentkeys+=-:

" Only define the function once.
if exists("*GetTomoIndent")
  finish
endif

function! GetTomoIndent()
  let line = getline(v:lnum)
  let current_ind = indent(v:lnum)
  let previousNum = prevnonblank(v:lnum - 1)
  let previous = getline(previousNum)
  let ind = indent(previousNum)

  if previous =~ '\(^\s*\<\(for\|while\|if\|else\|elseif\|between\|def\)\>\)\|^[^#]*[:=]\s*$'
    let ind = ind + &tabstop
  endif

  if line =~ '^\s*\(else\|elseif\|between\)$'
    return current_ind - &tabstop
  endif

  if ind == indent(previousNum)
      return current_ind
  endif
  return ind
endfunction
