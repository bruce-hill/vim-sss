" Language:    Tomo
" Maintainer:  Bruce Hill <bruce@bruce-hill.com>
" License:     WTFPL

if exists("b:did_indent")
  finish
endif

let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=GetTomoIndent()
setlocal indentkeys+=s

" Only define the function once.
if exists("*GetTomoIndent")
  finish
endif

function! GetTomoIndent()
  let line = getline(v:lnum)
  let current_ind = indent(v:lnum)
  let previousNum = prevnonblank(v:lnum - 1)
  let prev_line = getline(previousNum)
  let ind = indent(previousNum)

  if line =~ '^\s*else$'
    if prev_line =~ '^\s*else \+if\> .* then .*$' && current_ind == ind
      return current_ind
    else
      return current_ind - &tabstop
    endif
  endif

  if line =~ '^\s*\(skip\|stop\|pass\|return\|break\|continue\|)\(.*\<if\>\)\@!$'
    return current_ind - &tabstop
  endif

  if line =~ '^\s*is$'
    if prev_line =~ '^\s*is .* then .*$' && current_ind == ind
      return current_ind
    else
      return current_ind - &tabstop
    endif
  endif

  if prev_line =~ '\(^\s*\<\(for\|while\|if\|repeat\|when\|func\|convert\|lang\|struct\|enum\)\>\)\|^[^#]*[:=]\s*$'
    if prev_line !~ '^.* then '
      let ind = ind + &tabstop
    endif
  endif

  if ind == indent(previousNum)
      return current_ind
  endif
  return ind
endfunction
