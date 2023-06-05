" Language:    SSS
" Maintainer:  Bruce Hill <bruce@bruce-hill.com>
" License:     WTFPL

" Bail if our syntax is already loaded.
if exists('b:current_syntax') && b:current_syntax == 'sss'
  finish
endif

syn match SSSErrorWord /\i*/ contained
hi def link SSSErrorWord Error

syn match SSSVar /[a-zA-Z_][a-zA-Z_0-9]*/

syn match SSSNumber /0x[0-9a-fA-F_]\+%\?\|[0-9][0-9_]*\(\.\([0-9][0-9_]*\|\.\@!\)\)\?\(e[0-9_]\+\)\?%\?\|\.\@<!\.[0-9][0-9_]*\(e[0-9_]\+\)\?%\?/
hi def link SSSNumber Number

syn match SSSChar /`./
hi def link SSSChar String

syn region SSSString start=/".\@=/ end=/"\|$/ contains=SSSEscape,SSSStringInterp
syn region SSSString start=/'.\@=/ end=/'\|$/
syn region SSSString start=/".\@!\%(^\z(\s*\).*\)\@<=/ end=/^\z1"\|^\%(\z1\s\)\@!\s*\S\@=/ contains=SSSEscape,SSSStringInterp
syn region SSSString start=/'.\@!\%(^\z(\s*\).*\)\@<=/hs=e+1 end=/^\z1'\|^\%(\z1\s\)\@!\s*\S\@=/he=s-1
hi def link SSSString String

syn region SSSDSLString start=/\z(\W\).\@=/hs=e end=/\z1/ contains=SSSEscape,SSSStringInterp contained
syn region SSSDSLString start=/\z(\W\).\@!\%(^\z(\s*\).*\)\@<=/hs=e end=/^\z2\z1/he=e contains=SSSEscape,SSSStringInterp contained
syn region SSSDSLString start=/\[/hs=e+1 end=/]/he=s-1 contains=SSSEscape,SSSStringInterp contained
syn region SSSDSLString start=/{/hs=e+1 end=/}/he=s-1 contained
syn region SSSDSLString start=/</hs=e+1 end=/>/he=s-1 contains=SSSEscape contained
syn region SSSDSLString start=/(/hs=e+1 end=/)/he=s-1 contains=SSSStringInterp contained
syn region SSSDSLString start=/\//hs=e+1 end=/\//he=s-1 contains=SSSStringAtInterp contained
syn region SSSDSLString start=/>.\@=/hs=e+1 end=/$/ contains=SSSStringAtInterp contained
syn region SSSDSLString start=/>.\@!\%(^\z(\s*\).*\)\@<=/hs=e+1 end=/^\%(\z1\s\)\@!.\@=/ contains=SSSStringAtInterp contained
syn region SSSDSLString start=/:.\@=/hs=e+1 end=/$/ contains=SSSStringInterp,SSSEscape contained
syn region SSSDSLString start=/:.\@!\%(^\z(\s*\).*\)\@<=/hs=e+1 end=/^\%(\z1\s\)\@!.\@=/ contains=SSSStringInterp,SSSEscape contained
hi def link SSSDSLString String

syn match SSSDocTest /^\s*>>>/
syn region SSSDocTest start=/^\s*===/ end=/$/
hi SSSDocTest ctermfg=gray

syn match SSSDocError /!!!.*/
hi SSSDocError ctermfg=red cterm=italic

syn match SSSDSL /\$\w*/ nextgroup=SSSString,SSSDSLString
hi def link SSSDSL String
hi SSSDSL ctermfg=white cterm=bold

syn match SSSStringDollar /\$:\?/ contained
hi SSSStringDollar ctermfg=LightBlue

syn match SSSStringAt /@/ contained
hi SSSStringAt ctermfg=LightBlue

syn match SSSStringInterpWord /[a-zA-Z_][a-zA-Z_0-9]*\(\.[a-zA-Z_][a-zA-Z_0-9]*\)*/ contained
hi SSSStringInterpWord ctermfg=LightBlue

syn match SSSStringInterp /\$:\?/ contained nextgroup=SSSStringDollar,SSSStringInterpWord,@SSSAll
hi SSSStringInterp ctermfg=LightBlue

syn match SSSStringAtInterp /@/ contained nextgroup=SSSStringAt,SSSStringInterpWord,@SSSAll
hi SSSStringAtInterp ctermfg=LightBlue

syn match SSSEscape /\\\([abenrtvN]\|x\x\x\|\d\{3}\)\(-\([abnrtv]\|x\x\x\|\d\{3}\)\)\?\|\\./
hi SSSEscape ctermfg=LightBlue

syn keyword SSSConditional if unless elseif else when then defer
hi def link SSSConditional Conditional

syn keyword SSSLoop for between while repeat do until with
hi def link SSSLoop Repeat

syn keyword SSSFail fail
hi def link SSSFail Exception

syn keyword SSSStatement stop skip fail pass return del
hi def link SSSStatement Statement

syn region SSSUse matchgroup=Keyword start=/\<use\>/ matchgroup=SSSDelim end=/$\|;/ 
hi def link SSSUse String

syn keyword SSSExtend extend nextgroup=SSSType skipwhite
hi def link SSSExtend Keyword

syn match SSSArgDefault /=/ nextgroup=@SSSAll skipwhite contained
hi def link SSSArgDefault Operator
syn match SSSReturnSignature /->/ nextgroup=SSSType skipwhite contained
hi def link SSSReturnSignature Operator
syn region SSSFnArgSignature start=/(/ end=/)/ contains=SSSVar,SSSTypeAnnotation,SSSDelim,SSSArgDefault nextgroup=SSSReturnSignature skipwhite contained
syn match SSSFnName /\<[a-zA-Z_][a-zA-Z_0-9]*\>/ nextgroup=SSSFnArgSignature skipwhite contained
hi def link SSSFnName Function
syn keyword SSSDef def nextgroup=SSSFnName skipwhite
hi def link SSSDef Keyword

syn match SSSTagEquals /=/ skipwhite nextgroup=SSSErrorWord,SSSNumber contained
hi def link SSSTagEquals Operator
syn match SSSTagType /(/ nextgroup=SSSType contained
syn match SSSTag /[a-zA-Z_]\i*/ nextgroup=SSSTagType contained
hi SSSTag cterm=bold
syn region SSSTaggedUnion start=/{|/ end=/|}/ contains=SSSTag,SSSTagEquals

" syn region SSSFnDecl start=/\<def\>/ end=/(\@=\|$/ contains=SSSFnName,SSSKeyword

syn keyword SSSBoolean yes no
hi def link SSSBoolean Boolean

syn keyword SSSNil nil
hi SSSNil cterm=bold ctermfg=cyan

syn match SSSStructName /\w\+\( *{\)\@=/
hi SSSStructName cterm=bold

syn keyword SSSOperator of in by and or xor is not mod mod1 sizeof typeof bitcast _min_ _max_ _mix_
syn match SSSOperator /\(>>>\|===\)\@![+*/^<>=-]=\?/
syn match SSSOperator /\(===\)\@![:!]\?=/
syn match SSSOperator /[#?]/
hi def link SSSOperator Operator

syn match SSSDelim /,/
hi def link SSSDelim Delimiter

syn match SSSTableValueType /=>/ nextgroup=SSSType contained
hi def link SSSTableValueType Type
syn match SSSTypeDelim /,/ contained
hi def link SSSTypeDelim Type
syn match SSSAssoc /=/ contained
hi def link SSSAssoc Type
syn region SSSTypeUnits start=/</ end=/>/
hi def link SSSTypeUnits Type
syn region SSSType start=/\[/ end=/\]\|$/ contains=SSSType contained nextgroup=SSSTableValueType,SSSTypeUnits
syn region SSSType start=/{/ end=/}\|$/ contains=SSSType,SSSAssoc contained nextgroup=SSSTableValueType,SSSTypeUnits
syn region SSSType start=/(/ end=/) *->/ contains=SSSType,SSSTypeDelim nextgroup=SSSType contained
syn match SSSType /[a-zA-Z_]\i*/ contained nextgroup=SSSTableValueType,SSSTypeUnits
syn match SSSType /\$[a-zA-Z_0-9]\+/ contained nextgroup=SSSTableValueType,SSSTypeUnits
syn match SSSType /[@?&]\+/ contained nextgroup=SSSType
hi def link SSSType Type

syn match SSSTypeAnnotation /:\@<!:[=:]\@!/ nextgroup=SSSType
hi def link SSSTypeAnnotation Operator

syn keyword SSSAs as nextgroup=SSSType skipwhite
hi def link SSSAs Operator

syn region SSSComment start=;//; end=/$/
hi def link SSSComment Comment

" syn region SSSParenGroup start=/(/ end=/)/ contains=@SSSAll

syn match SSSLinkerDirective ;^\s*!link.*$;
hi SSSLinkerDirective ctermbg=blue ctermfg=black

syn cluster SSSAll contains=SSSVar,SSSComment,SSSChar,SSSString,SSSDSL,SSSExtend,SSSKeyword,SSSOperator,
      \SSSConditional,SSSLoop,SSSFail,SSSStatement,SSSStructure,SSSTypedef,SSSEmptyTable,
      \SSSNumber,SSSFnDecl,SSSBoolean,SSSNil,SSSTypeAnnotation,SSSAs,SSSDocTest,SSSDocError
      \SSSLinkerDirective

if !exists('b:current_syntax')
  let b:current_syntax = 'bpeg'
endif
