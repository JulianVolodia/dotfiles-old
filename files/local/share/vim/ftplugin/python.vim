" TODO:
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

" Vim-IPython plugin {{{
" Only use IPython completion for Python buffers
let g:ipy_completefunc = 'local'

" Don't use default mappings
let g:ipy_perform_mappings = 0
" Starts Vim-IPython integration
noremap <buffer> <localleader>I :IPython<cr>
" Run current line/selected text in IPython, dedent by indentation of first
" line in selection
noremap <silent> <buffer> <localleader>r :python dedent_run_this_line()<cr>
" Run current line/currently selected text in IPython, keep indentation
noremap <silent> <buffer> <localleader>R :python run_this_line()<cr>
" Run entire buffer in IPython
noremap <silent> <buffer> <localleader><return> :python run_this_file()<cr>
" Get docstring of item under cursor in preview window
map <silent> <buffer> <localleader>d :py get_doc_buffer()<cr>
" Open Vim-IPython shell
map <silent> <buffer> <localleader>s :py if update_subchannel_msgs(force=True): echo("vim-ipython shell updated",'Operator')<cr>
" Toggle sending entire buffer to IPython when saving (default: off)
map <buffer> <localleader>S :call <SID>toggle_send_on_save()<cr>
"map <silent> <buffer> <C-F6> :python send('%pdb')<cr>
"map <silent> <buffer> <F6> :python set_breakpoint()<cr>
"map <silent> <buffer> <s-F6> :python clear_breakpoint()<cr>
"map <silent> <buffer> <F7> :python run_this_file_pdb()<cr>
"map <silent> <buffer> <s-F7> :python clear_all_breaks()<cr>
"" Example of how to quickly clear the current plot with a keystroke
"map <silent> <F12> :python run_command("plt.clf()")<cr>
"" Example of how to quickly close all figures with a keystroke
"map <silent> <F11> :python run_command("plt.close('all')")<cr>

" }}}
