" Settings {{{
" Disable default keybindings
let g:LatexBox_no_mappings = 1
" Use spaces as wildcards in BibTeX completion
let g:LatexBox_bibtex_wild_spaces = 1
" Allow folding; caution: takes \end{document} hostage
let g:LatexBox_Folding = 1

" Use LuaLaTeX as default
" Enable quickfix error parsing
" Use -shell-escape for minted
let g:LatexBox_latexmk_options = "-file-line-error -shell-escape -pdflatex=lualatex"
" Don't automatically jump to first error after calling latexmk
let g:LatexBox_autojump = 0
" I use cleveref, so citation completion for it is a nice thing to have
let g:LatexBox_ref_pattern = '\\\(\(namec\|nameC|lcnamec\)refs\?\|\(label\)\?[cC]\?\(page\)\?ref\(range\)\?\){'

" }}}
" Mappings {{{
" Latexmk interface {{{
" Compile with latexmk in background
noremap <buffer> <silent> <localleader>ll :Latexmk<cr>
" Force latexmk compilation
noremap <buffer> <silent> <localleader>lL :LatexmkForce<cr>
" Clean temporary compilation output
noremap <buffer> <silent> <localleader>lc :LatexmkClean<cr>
" Clean all compilation output
noremap <buffer> <silent> <localleader>lC :LatexmkClean!<cr>
" Stop latexmk if it is running
noremap <buffer> <silent> <localleader>lk :LatexmkStop<cr>
" Show running status for current buffer
noremap <buffer> <silent> <localleader>ls :LatexmkStatus<cr>
" Show running status for all buffers within process group
noremap <buffer> <silent> <localleader>lS :LatexmkStatus!<cr>
" Load log file for current document and jump to first error
noremap <buffer> <silent> <localleader>le :LatexErrors<cr>
" View output
noremap <buffer> <silent> <localleader>lv :LatexView<cr>

" }}}
" {{{
nmap <buffer> % <Plug>LatexBox_JumpToMatch
vmap <buffer> % <Plug>LatexBox_JumpToMatch
omap <buffer> % <Plug>LatexBox_JumpToMatch
vmap <buffer> ie <Plug>LatexBox_SelectCurrentEnvInner
vmap <buffer> ae <Plug>LatexBox_SelectCurrentEnvOuter
omap <buffer> ie :normal vie<cr>
omap <buffer> ae :normal vae<cr>
vmap <buffer> i$ <Plug>LatexBox_SelectInlineMathInner
vmap <buffer> a$ <Plug>LatexBox_SelectInlineMathOuter
omap <buffer> i$ :normal vi$<cr>
omap <buffer> a$ :normal va$<cr>
map <buffer> <silent> <tab> %

" }}}
" Change the current environment
nmap <buffer> <silent> <LocalLeader>e <Plug>LatexChangeEnv
" Wrap the current selection in a LaTeX command
vmap <buffer> <silent> <LocalLeader>w <Plug>LatexWrapSelection
" Wrap the current selection in an environment
vmap <buffer> <silent> <LocalLeader>W <Plug>LatexEnvWrapSelection
" The taglist plugin is not very useful for larger documents, so its key is
" remapped to LaTeX-Box's TOC
noremap <buffer> <silent> <F4> :LatexTOC<cr>

" }}}
