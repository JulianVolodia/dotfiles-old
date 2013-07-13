" TODO:
" - IPython integration with already started IPython kernel
" - nose integration
"   (see http://www.vim.org/scripts/script.php?script_id=3842)
" - rope integration
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
