setlocal spell
setlocal wrap
setlocal textwidth=80

nnoremap <buffer> j gj
nnoremap <buffer> k gk
nnoremap <buffer> $ g$
nnoremap <buffer> ^ g^

" Add '$' to quote symbols for delimitMate (so that $ -> $$)
let b:delimitMate_quotes = "\" ' $"

setlocal formatlistpat+=\\\|^\\*\\s*
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,b:-
setlocal formatoptions=tcroqln

setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
