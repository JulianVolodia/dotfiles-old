" TODO:
" - nose integration
"   (see http://www.vim.org/scripts/script.php?script_id=3842)
" - rope integration
" - tab completion
" - virtualenv integration
" - See http://sontek.net/turning-vim-into-a-modern-python-ide
" - makegreen
"   (See http://blog.staz.be/?post/2010/09/04/Python-unit-test-and-vim)

setlocal softtabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal expandtab
"
" Wrap at 78 chars for code
setlocal textwidth=78
" Wrap at 72 chars for comments
setlocal formatoptions=cq textwidth=72 foldignore= wildignore+=*.py

" PEP8 plugin
" Calls the plugin
noremap <buffer> <localleader>8 :call Pep8()<cr>

" Pylint plugin
" Don't call pylint every time I write a file
let b:pylint_onwrite = 0
" Who needs code rate, really
let b:pylint_show_rate = 0
" Open pylint output in quickfix window
let b:pylint_cwindow = 0
" Don't show funny signs
let b:pylint_signs = 0
" Compile to pylint
map <buffer> <localleader>pl :call CompilePylint()<cr>
fu! CompilePylint()
    compiler pylint
    Pylint
endf
