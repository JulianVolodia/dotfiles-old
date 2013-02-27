" Bundles {{{
Bundle 'git://github.com/gmarik/vundle'
Bundle 'git://github.com/ervandew/ag'
Bundle 'git://github.com/tpope/vim-commentary'
Bundle 'git://github.com/vim-scripts/DeleteTrailingWhitespace'
Bundle 'git://github.com/sjl/gundo.vim.git'
Bundle 'git://github.com/ivanov/vim-ipython'
Bundle 'git://github.com/LaTeX-Box-Team/LaTeX-Box'
Bundle 'git://github.com/ludovicchabant/vim-lawrencium'
Bundle 'git://github.com/MarcWeber/vim-addon-local-vimrc'
Bundle 'git://github.com/edsono/vim-matchit'
Bundle 'git://github.com/Lokaltog/vim-powerline'
Bundle 'git://github.com/kien/rainbow_parentheses.vim'
Bundle 'git://github.com/tpope/vim-repeat'
Bundle 'git://github.com/vim-scripts/ShowTrailingWhitespace'
Bundle 'git://github.com/tmhedberg/SimpylFold'
Bundle 'git://github.com/sjl/splice.vim.git'
Bundle 'git://github.com/tpope/vim-surround'
Bundle 'git://github.com/scrooloose/syntastic'
Bundle 'git://github.com/godlygeek/tabular'
Bundle 'git://github.com/majutsushi/tagbar'
Bundle 'git://github.com/maxbrunsfeld/vim-yankstack'
Bundle 'git://github.com/SirVer/ultisnips'
Bundle 'git://github.com/ervandew/supertab'

" }}}
" Configuration {{{
" Some preliminary remarks:
" - all plugin functions that open some kind of split window have mapped that
"   the opening/toggling of said window to a function key
" - functions that toggle other stuff are normally either <leader><key> if I
"   use them sparingly, or use their own keys if I use them often (e.g.
"   commentary and üü)
" Ag {{{
noremap <leader>a :Ag<space>

" }}}
" Commentary {{{
" Use ü and üü for commenting
xmap ü <Plug>Commentary
nmap ü <Plug>Commentary
nmap üü <Plug>CommentaryLine
nmap üu <Plug>CommentaryUndo

" }}}
" DeleteTrailingWhitespace {{{
" Don't automatically delete on writing a buffer
let g:DeleteTrailingWhitespace = 0
" Do this to fix trailing whitespace
noremap <silent> <leader>d<space> :DeleteTrailingWhitespace<cr>

" }}}
" Gundo {{{
" Toggles the Gundo windows
" It looks kinda like a tree, see? See?
noremap <f3> :GundoToggle<cr>
" horizontal width of Gundo graph
let g:gundo_width = 50
" Vertical height of preview window
"let g:gundo_preview_height = 25
" Show preview window below file instead of below graph
" let g:gundo_preview_bottom = 0
" Show Gundo graph on the right
"let g:gundo_right = 1
" automatically close Gundo windows on reverting
let g:gundo_close_on_revert = 1

" }}}
" Lawrencium {{{
" I like my own mappings better
let g:lawrencium_define_mappings = 0
" :Hgedit
noremap <leader>ve :Hgedit<space>
" :Hgcd
noremap <leader>vcd :Hgcd<space>
" :Hglcd
noremap <leader>vcl :Hglcd<space>
" Open annotation window
noremap <silent> <leader>va :Hgannotate<cr>
" Open status window
noremap <silent> <leader>vs :Hgstatus<cr>
" Open log window for current file
noremap <silent> <leader>vl :Hglogthis<cr>
" Open log window for entire repository
noremap <silent> <leader>vL :Hglog<cr>
" Open diff window
noremap <silent> <leader>vd :Hgdiff<cr>
" Open vertical diff window
noremap <silent> <leader>vvd :Hgvdiff<cr>
" Open diffsum window
noremap <silent> <leader>vD :Hgdiffsumsplit<cr>
" Open vertical diffsum window
noremap <silent> <leader>vvD :Hgvdiffsumsplit<cr>
" Open commit buffer
noremap <silent> <leader>vC :Hgcommit<cr>
" Open vertical commit buffer
noremap <silent> <leader>vvC :Hgvcommit<cr>
" Revert current file to previous revision
noremap <silent> <leader>vr :Hgrevert<cr>
" Revert current file to previous revision (no backup)
noremap <silent> <leader>vR :Hgrevert!<cr>
" }}}
" Powerline {{{
" Set mode names
let g:Powerline_mode_n = ' N '
let g:Powerline_mode_i = ' I '
let g:Powerline_mode_R = ' R '
let g:Powerline_mode_v = ' V '
let g:Powerline_mode_V = 'VLN'
let g:Powerline_mode_cv = 'VBL'
let g:Powerline_mode_s = ' S '
let g:Powerline_mode_S = 'SLN'
let g:Powerline_mode_cs = 'SBL'
" TODO: Theme
" }}}
" Rainbow Parentheses {{{
" TODO:
" - Add explicit color mappings
" Toggle display of all kinds of parens
noremap <silent> <leader>r :RainbowParenthesesToggleAll<cr>

" }}}
" ShowTrailingWhitespace {{{
" Show it by default
let g:ShowTrailingWhitespace = 1
" ZOMGWTFBBQ
" I mean, toggle trailing whitespace display for current buffer
noremap <silent> <leader><space> :<c-u>call ShowTrailingWhitespace#Toggle(0)<bar>echo (ShowTrailingWhitespace#IsSet() ? 'Showing trailing whitespace' : 'Not showing trailing whitespace')<cr>
"
" }}}
" Splice {{{
" Use this as the splice prefix
let g:splice_prefix = "<leader>s"
" Use scrollbind on all modes
let g:splice_initial_scrollbind_grid = 1
let g:splice_initial_scrollbind_loupe = 1
let g:splice_initial_scrollbind_compare = 1
let g:splice_initial_scrollbind_path = 1

" }}}
" Supertab {{{
" Let supertab make out completion context
" Uses completefunc if set, or else omnifunc
" Else: Falls back to secondary default as specified by
" g:SuperTabContextDefaultCompletionType
let g:SuperTabDefaultCompletionType = "context"
" Use this as fallback
let g:SuperTabContextDefaultCompletionType = "<c-n>"
" Complete longest common match (like in shells)
let g:SuperTabLongestEnhanced = 1
" Automatically select first entry in menu
let g:SuperTabLongestHighlight = 1
" Use this to move forward
let g:SuperTabMappingForward = "<tab>"
" Use this to move backward
let g:SuperTabMappingBackward = "<s-tab>"
" Use this to display the normal <tab> character (is still affected by
" expandtab, shiftwidth, etc.)
" Doesn't work in terminal
let g:SuperTabMappingTabLiteral = "<c-tab>"
" Use <cr> to cancel completion
let g:SuperTabCrMapping = 1
" Automatically close preview window when popup window is closed
let g:SuperTabClosePreviewOnPopupClose = 1

" }}}
" Syntastic {{{
" Don't run Syntastic on opening files
let g:syntastic_check_on_open = 0
" Print error message for current line to command window
let g:syntastic_echo_current_error = 1
" Use the :sign interface to show errors
let g:syntastic_enable_signs = 1
" Use these symbols for errors, warnings, and style errors/warnings
let g:syntastic_error_symbol = 'E'
let g:syntastic_warning_symbol = 'W'
let g:syntastic_style_error_symbol = 'S'
let g:syntastic_style_warning_symbol = 's'
" Don't use balloons
let g:syntastic_enable_balloons = 0
" Don't use syntax highlighting
let g:syntastic_enable_highlighting = 0
" Don't automatically jump to the first error when first opening a file
let g:syntastic_auto_jump = 0
" Automatically close location list when no more errors are found
let g:syntastic_auto_loc_list = 2
" Error list height = command window height
let g:syntastic_loc_list_height = 7
" Don't automatically check
let g:syntastic_mode_map = { 'mode': 'passive' }
" Check manually
noremap <leader>S :SyntasticCheck<cr>

" }}}
" Tagbar {{{
" Open tagbar window on the left
let tagbar_left = 1
" Make tagbar window as wide as the gundo plugin windows
let tagbar_width = 50
" Automatically jump to tagbar window as soon as it's opened
let tagbar_autofocus = 1
" Automatically close tagbar window when choosing a tag
let tagbar_autoclose = 1
" If current tag is inside a closed fold, open that fold just enough to show
" the tag
let tagbar_autoshowtag = 1
" Toggle Tagbar window
nnoremap <silent> <f4> :TagbarToggle<cr>

" }}}
" UltiSnips {{{
" Don't reverse search order
let g:UltiSnipsDontReverseSearchPath = "1"
" Snippet directory for private snippets
let g:UltiSnipsSnippetsDir = "$XDG_DATA_HOME/vim/snippets"
" Snippet search path
" The default snippets are in <bundledir>/ultisnips/UltiSnips directory
let g:UltiSnipsSnippetDirectories = ["snippets", "UltiSnips"]
" " Use this to expand a trigger (i.e. insert a snippet)
let g:UltiSnipsExpandTrigger = "<tab>"
" Use this to jump forward to next trigger
let g:UltiSnipsJumpForwardTrigger = "<tab>"
" Use this to jump backward to next trigger
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" NOTE: UltiSnips automatically falls back on Supertab completion if there's
" no snippet to expand

" }}}
" Yankstack {{{
" Don't load default maps
let g:yankstack_map_keys = 0
"map Use + and - to cycle through yank stack
nmap <silent> + <Plug>yankstack_substitute_older_paste
nmap <silent> - <Plug>yankstack_substitute_newer_paste
" Use this to show yank stack
nnoremap <f2> :Yanks<cr>
" Needs to be called before redefining yank maps
call yankstack#setup()

" }}}

" }}}

" vim: foldmethod=marker
