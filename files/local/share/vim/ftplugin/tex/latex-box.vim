" Settings {{{
" Disable default keybindings
" Caution: Also have to define errorformat and omnifunc
" let g:LatexBox_no_mappings = 1
" Use spaces as wildcards in BibTeX completion
let g:LatexBox_bibtex_wild_spaces = 1
" Allow folding; caution: takes \end{document} hostage
" let g:LatexBox_Folding = 1

" Use LuaLaTeX as default
" Use "continuous viewing"
" Enable quickfix error parsing
let g:LatexBox_latexmk_options = "-file-line-error -pdflatex=lualatex"
" Automatically jump to first error after calling latexmk
let g:LatexBox_autojump = 1
" }}}

" Mappings {{{
" Redefine standard %
map <buffer> <silent> <tab> %
" Close the last matching open environment
imap <buffer> <silent> ]] <Plug>LatexCloseCurEnv
" Change the current environment
nmap <buffer> <silent> <LocalLeader>e <Plug>LatexChangeEnv
" Wrap the current selection in a LaTeX command
vmap <buffer> <silent> <LocalLeader>w <Plug>LatexWrapSelection
" Wrap the current selection in an environment
vmap <buffer> <silent> <LocalLeader>W <Plug>LatexEnvWrapSelection
" }}}
