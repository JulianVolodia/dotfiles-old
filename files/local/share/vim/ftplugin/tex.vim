" this is mostly a matter of taste. but LaTeX looks good with just a bit of
" indentation.
setlocal sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you type
" in \ref{fig: and press <C-n> you will automatically cycle through all the
" figure labels. Very useful!
setlocal iskeyword+=:

let g:tex_flavor = "latex"

" How to compile pdf files
let g:Tex_CompileRule_pdf = 'pdflatex $*'

" Compiles those file types multiple times if necessary
let g:Tex_MultipleCompileFormats = 'dvi,pdf'

" Compile to pdf instead of dvi
let g:Tex_DefaultTargetFormat = 'pdf'

" Use zathura to preview output
let g:Tex_ViewRule_pdf = 'mupdf'

" Ignore FontWarnings
let g:Tex_IgnoredWarnings =
            \"Underfull\n".
            \"Overfull\n".
            \"specifier changed to\n".
            \"You have requested\n".
            \"Missing number, treated as zero.\n".
            \"There were undefined references\n".
            \"Citation %.%# undefined\n".
            \'LaTeX Font Warning:'"
