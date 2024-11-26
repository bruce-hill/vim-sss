" Language:    SSS
" Maintainer:  Bruce Hill <bruce@bruce-hill.com>
" License:     WTFPL

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal formatoptions-=t
setlocal cpoptions+=M

setlocal commentstring=#\ %s

let b:undo_ftplugin = "setlocal formatoptions< cpoptions<"
