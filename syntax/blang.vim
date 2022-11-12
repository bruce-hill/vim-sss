" Language:    Blang
" Maintainer:  Bruce Hill <bruce@bruce-hill.com>
" License:     WTFPL

" Bail if our syntax is already loaded.
if exists('b:current_syntax') && b:current_syntax == 'blang'
  finish
endif

syn match BlangVar /[a-zA-Z_][a-zA-Z_0-9]*/ contained

syn region BlangString start=/".\@=/ end=/"\|$/ contains=BlangEscape,BlangStringInterp
syn region BlangString start=/'.\@=/ end=/'\|$/
syn region BlangString start=/".\@!\%(^\z(\s*\).*\)\@<=/ end=/^\z1"\|^\%(\z1\s\)\@!\s*\S\@=/ contains=BlangEscape,BlangStringInterp
syn region BlangString start=/'.\@!\%(^\z(\s*\).*\)\@<=/hs=e+1 end=/^\z1'\|^\%(\z1\s\)\@!\s*\S\@=/he=s-1
hi def link BlangString String

syn region BlangDSLString start=/\z(\W\).\@=/hs=e end=/\z1/ contains=BlangEscape,BlangStringInterp contained
syn region BlangDSLString start=/\z(\W\).\@!\%(^\z(\s*\).*\)\@<=/hs=e end=/^\z2\z1/he=e contains=BlangEscape,BlangStringInterp contained
syn region BlangDSLString start=/\[/hs=e+1 end=/]/he=s-1 contains=BlangEscape,BlangStringInterp contained
syn region BlangDSLString start=/{/hs=e+1 end=/}/he=s-1 contained
syn region BlangDSLString start=/</hs=e+1 end=/>/he=s-1 contains=BlangEscape contained
syn region BlangDSLString start=/(/hs=e+1 end=/)/he=s-1 contains=BlangStringInterp contained
syn region BlangDSLString start=/>.\@=/hs=e+1 end=/$/ contains=BlangStringAtInterp contained
syn region BlangDSLString start=/>.\@!\%(^\z(\s*\).*\)\@<=/hs=e+1 end=/^\%(\z1\s\)\@!.\@=/ contains=BlangStringAtInterp contained
syn region BlangDSLString start=/:.\@=/hs=e+1 end=/$/ contains=BlangStringInterp,BlangEscape contained
syn region BlangDSLString start=/:.\@!\%(^\z(\s*\).*\)\@<=/hs=e+1 end=/^\%(\z1\s\)\@!.\@=/ contains=BlangStringInterp,BlangEscape contained
hi def link BlangDSLString String

syn match BlangDSL /%\w\+/ nextgroup=BlangString,BlangDSLString
hi def link BlangDSL String
hi BlangDSL ctermfg=white cterm=bold

syn match BlangStringDollar /\$/ contained
hi BlangStringDollar ctermfg=LightBlue

syn match BlangStringAt /@/ contained
hi BlangStringAt ctermfg=LightBlue

syn match BlangStringInterpWord /[a-zA-Z_][a-zA-Z_0-9]*/ contained
hi BlangStringInterpWord ctermfg=LightBlue

syn match BlangStringInterp /\$/ contained nextgroup=BlangStringDollar,BlangStringInterpWord,@BlangAll
hi BlangStringInterp ctermfg=LightBlue

syn match BlangStringAtInterp /@/ contained nextgroup=BlangStringAt,BlangStringInterpWord,@BlangAll
hi BlangStringAtInterp ctermfg=LightBlue

syn match BlangEscape /\\\([abenrtvN]\|x\x\x\|\d\{3}\)\(-\([abnrtv]\|x\x\x\|\d\{3}\)\)\?\|\\./
hi BlangEscape ctermfg=LightBlue

syn match BlangNumber /0x[0-9a-fA-F_]\+%\?\|[0-9][0-9_]*\(\.\([0-9][0-9_]*\|\.\@!\)\)\?\(e[0-9_]\+\)\?%\?\|\.\@<!\.[0-9][0-9_]*\(e[0-9_]\+\)\?%\?/
hi def link BlangNumber Number

syn keyword BlangConditional if unless elseif else when then
hi def link BlangConditional Conditional

syn keyword BlangLoop for between while repeat do until
hi def link BlangLoop Repeat

syn keyword BlangFail fail
hi def link BlangFail Exception

syn keyword BlangStatement stop skip fail pass return
hi def link BlangStatement Statement

syn keyword BlangStructure struct unit enum union
hi def link BlangStructure Structure

syn keyword BlangTypedef deftype
hi def link BlangTypedef Typedef

syn keyword BlangKeyword macro deftype use export extern
hi def link BlangKeyword Keyword

syn match BlangFnName /\<[a-zA-Z_][a-zA-Z_0-9]*\>/ contained
hi def link BlangFnName Function
syn keyword BlangDef def nextgroup=BlangFnName skipwhite
hi def link BlangDef Keyword

" syn region BlangFnDecl start=/\<def\>/ end=/(\@=\|$/ contains=BlangFnName,BlangKeyword

syn keyword BlangBoolean yes no
hi def link BlangBoolean Boolean

syn keyword BlangNil nil
hi BlangNil cterm=bold ctermfg=cyan

syn match BlangStructName /\w\+\( *{\)\@=/
hi BlangStructName cterm=bold

syn keyword BlangOperator in and or xor is not mod sizeof typeof
syn match BlangOperator /\<\(and\|or\|xor\|mod\)=/
syn match BlangOperator /[+*/^<>=-]=\?/
syn match BlangOperator /[:!]\?=/
hi def link BlangOperator Operator

syn match BlangDelim /,/
hi def link BlangDelim Dlimiter

syn match BlangTypeDelim /,/ contained
hi def link BlangTypeDelim Type
syn match BlangAssoc /=/ contained
hi def link BlangAssoc Type
syn region BlangType start=/\[/ end=/\]\|$/ contains=BlangType contained
syn region BlangType start=/{/ end=/}\|$/ contains=BlangType,BlangAssoc contained
syn region BlangType start=/(/ end=/)=>\|$/ contains=BlangType,BlangTypeDelim nextgroup=BlangType contained
syn match BlangType /\w\+/ contained
hi def link BlangType Type

syn match BlangTypeAnnotation /:=\@!/ nextgroup=BlangType skipwhite
hi def link BlangTypeAnnotation Operator

syn match BlangAs /\<as\>/ nextgroup=BlangType skipwhite
hi def link BlangAs Operator

syn region BlangComment start=;//; end=/$/
hi def link BlangComment Comment

syn region BlangParenGroup start=/(/ end=/)/ contains=@BlangAll

syn cluster BlangAll contains=BlangComment,BlangString,BlangDSL,BlangKeyword,
      \BlangConditional,BlangLoop,BlangFail,BlangStatement,BlangStructure,BlangTypedef,
      \BlangNumber,BlangFnDecl,BlangBoolean,BlangNil,BlangTypeAnnotation,BlangAs,BlangParenGroup

if !exists('b:current_syntax')
  let b:current_syntax = 'bpeg'
endif
