" Open file mentioned on the current line
noremap <silent> <buffer> <cr> :Hgstatusedit<cr>
" Diff file on current line
noremap <silent> <buffer> <leader>vd :Hgstatusdiff<cr>
" Diffsum for file on current line or in selection
noremap <silent> <buffer> <leader>vD :Hgstatusdiffsum<cr>
" Commit file on current line or in selection
noremap <silent> <buffer> <leader>vC :Hgstatuscommit<cr>
