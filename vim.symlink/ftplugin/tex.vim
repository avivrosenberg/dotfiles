" TeX-specific settings
setlocal spell
setlocal wrap
setlocal textwidth=80
setlocal conceallevel=2

" Add ':' and '-' to iskeyword so that CTRL-N and other completions work with
" things like 'eq:foo-bar'.
setlocal iskeyword+=:,-

nnoremap <buffer> j gj
nnoremap <buffer> k gk
nnoremap <buffer> $ g$
nnoremap <buffer> ^ g^

" Add '$' to quote symbols for delimitMate (so that $ -> $$)
let b:delimitMate_quotes = "\" ' $"

" Define ` and ' as matching pairs for latex
let b:delimitMate_matchpairs = "(:),[:],{:},<:>,`:'"

" Abbreviations
iabbrev <buffer> Ca Ca\textsuperscript{2+}
iabbrev <buffer> Na Na\textsuperscript{+}
