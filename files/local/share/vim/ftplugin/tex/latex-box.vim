" Settings {{{
" Disable default keybindings
let g:LatexBox_no_mappings = 1
" Use spaces as wildcards in BibTeX completion
let g:LatexBox_bibtex_wild_spaces = 1

" Use LuaLaTeX as default
let g:LatexBox_latexmk_options = "-pdflatex=lualatex"
" Don't automatically jump to first error after calling latexmk
let g:LatexBox_autojump = 0
" }}}

" Mappings {{{
" Compile with latexmk in background
noremap <buffer> <LocalLeader>ll :Latexmk
" Force compilation with latexmk in background
noremap <buffer> <LocalLeader>lL :LatexmkForce
" Clean temporary output from LaTeX
noremap <buffer> <LocalLeader>lc :LatexmkClean
" Clean all output from LaTeX
noremap <buffer> <LocalLeader>lC :LatexmkCleanAll
" Stop latexmk if it is running
noremap <buffer> <LocalLeader>lk :LatexmkStop
" Show the running status of latexmk for the current buffer
noremap <buffer> <LocalLeader>lg :LatexmkStatus
" Show the running status of latexmk for all buffers with process group
" IDs
noremap <buffer> <LocalLeader>lG :LatexmkStatusDetailed
" Load the log file for the current document and jump to the first error
" TODO: Is that really necessary?
noremap <buffer> <LocalLeader>le :LatexmkErrors

" View output file
noremap <buffer> <LocalLeader>v :LatexView
" Close the last matching open environment


inoremap <buffer> <silent> ]] <Plug>LatexCloseCurEnv
" Change the current environment
nnoremap <buffer> <silent> <LocalLeader>e <Plug>LatexChangeEnv
" Wrap the current selection in a LaTeX command
vnoremap <buffer><silent> <LocalLeader>w <Plug>LatexWrapSelection
" Wrap the current selection in an environment
vnoremap <buffer> <silent> <LocalLeader>W <Plug>LatexEnvWrapSelection
" }}}
