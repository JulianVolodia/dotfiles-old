" Settings {{{
" Use omni-completion by default
" Context completion doesn't deal well with import completion, so I'll just
" set omnicompletion as the default
" TODO: Look into completion context chaining to maybe chain
" completefunc -> context -> omnifunc
call SuperTabSetDefaultCompletionType("<c-x><c-o>")
" I like my own completeopt, thank you very much
let g:jedi#auto_vim_configuration = 0
" Use jedi#complete as omnifunc
" This leaves completefunc free for vim-ipython in case it is used
setlocal omnifunc=jedi#complete
" I like buffers better
let g:jedi#use_tabs_not_buffers = 0
" Don't automatically start completion on typing a dot
let g:jedi#popup_on_dot = 0
" Automatically select first completion entry
let g:jedi#popup_select_first = 1
" Automatically close preview window after finishing a completion
let g:jedi#auto_close_doc = 1
" Show a window with the current function definition
let g:jedi#show_function_definition = 1
call jedi#configure_function_definition()

" }}}
" Keybindings {{{
" These all work on the item currently under the cursor
" Go to definition (shadows similar Vim keybinding)
noremap <silent> <buffer> gd :call jedi#goto()<cr>
" Go to original definition (shadows similar Vim keybinding)
noremap <silent> <buffer> gD :call jedi#get_definition()<cr>
" Show list of related names
noremap <silent> <buffer> <localleader>n :call jedi#related_names()<cr>
" Rename variable
noremap <silent> <buffer> <localleader>r :call jedi#rename()<cr>
" Show pydoc documentation
nnoremap <silent> <buffer> <localleader>K :call jedi#show_pydoc()<cr>

" }}}

" vim: foldmethod=marker
