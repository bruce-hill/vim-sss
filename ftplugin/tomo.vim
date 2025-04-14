" Language:    Tomo
" Maintainer:  Bruce Hill <bruce@bruce-hill.com>
" License:     WTFPL

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal formatoptions-=t
setlocal cpoptions+=M
setlocal expandtab shiftwidth=4 tabstop=4

setlocal commentstring=#\ %s

let b:undo_ftplugin = "setlocal formatoptions< cpoptions< expandtab< shiftwidth< tabstop< commentstring<"
