" Settings {{{
" Disable default keybindings
let g:LatexBox_no_mappings = 1
" Use spaces as wildcards in BibTeX completion
let g:LatexBox_bibtex_wild_spaces = 1
" Allow folding
let g:LatexBox_Folding = 1
" Change Supertab default context to omnifunc, is local to current buffer
call SuperTabSetDefaultCompletionType("<c-x><c-o>")

" Use LuaLaTeX as default
" Enable quickfix error parsing
" Use -shell-escape for minted
let g:LatexBox_latexmk_options = "-file-line-error -shell-escape -pdflatex=lualatex"
" Don't automatically open quickfix window after compilation
let g:LatexBox_quickfix = 0
" Don't automatically jump to first error after calling latexmk
let g:LatexBox_autojump = 0
" I use cleveref, so citation completion for it is a nice thing to have
" let g:LatexBox_ref_pattern = '\\\(\(lc\)\?name\[Cc\]refs\?\|\(label\)\?[cC]\?\(page\)\?ref\(range\)\?\){'

" }}}
" Mappings {{{
" Latexmk interface {{{
" Compile with latexmk in background
noremap <buffer> <silent> <localleader>l :Latexmk<cr>
" Force latexmk compilation
noremap <buffer> <silent> <localleader>L :LatexmkForce<cr>
" Clean temporary compilation output
noremap <buffer> <silent> <localleader>c :LatexmkClean<cr>
" Clean all compilation output (including generated output file)
noremap <buffer> <silent> <localleader>C :LatexmkClean!<cr>
" Stop latexmk if it is running
noremap <buffer> <silent> <localleader>k :LatexmkStop<cr>
" Show running status for current buffer
noremap <buffer> <silent> <localleader>s :LatexmkStatus<cr>
" View output
noremap <buffer> <silent> <localleader>v :LatexView<cr>

" }}}
" Movement commands {{{
" Jump to corresponding match
nmap <buffer> <silent> % <Plug>LatexBox_JumpToMatch
vmap <buffer> % <Plug>LatexBox_JumpToMatch
omap <buffer> % <Plug>LatexBox_JumpToMatch
" Select in environment
vmap <buffer> ie <Plug>LatexBox_SelectCurrentEnvInner
omap <buffer> ie :normal vie<cr>
" Select an environment
vmap <buffer> ae <Plug>LatexBox_SelectCurrentEnvOuter
omap <buffer> ae :normal vae<cr>
" Select in math environment
vmap <buffer> i$ <Plug>LatexBox_SelectInlineMathInner
omap <buffer> i$ :normal vi$<cr>
" Select a math environment
vmap <buffer> a$ <Plug>LatexBox_SelectInlineMathOuter
omap <buffer> a$ :normal va$<cr>
" Easier jumping to match
map <buffer> <silent> <tab> %

" }}}
" Wrapping commands {{{
" Change the current environment
nmap <buffer> <silent> <LocalLeader>e <Plug>LatexChangeEnv
" Wrap the current selection in a LaTeX command
vmap <buffer> <silent> <LocalLeader>w <Plug>LatexWrapSelection
" Wrap the current selection in an environment
vmap <buffer> <silent> <LocalLeader>W <Plug>LatexEnvWrapSelection
" The tagbar plugin is not very useful for larger documents, so its key is
" remapped to LaTeX-Box's TOC
noremap <buffer> <silent> <F4> :call LatexBox_TOC()<cr>

" }}}

" }}}

" vim: foldmethod=marker
