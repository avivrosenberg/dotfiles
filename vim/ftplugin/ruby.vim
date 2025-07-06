" Customizations for Ruby

" ruby indentation
setlocal ts=2 sts=2 sw=2

" run current ruby file (the 'cd .' part is for RVM, incase a file that RVM
" looks for exists, it will cause it to be read (files like .rmvrc,
" .ruby-version and .ruby-gemset).
nmap <buffer> <F5> :w<CR>:!cd . && ruby %<CR>

" Replace ctags leader mapping with ripper-tags mapping (in ruby buffers only)
if executable('ripper-tags')
    nnoremap <buffer> <Leader>T :!ripper-tags -R --exclude=vendor<CR>
endif

" Spell checking (the vim-ruby plugin makes sure this only affect comments)
setlocal spell
