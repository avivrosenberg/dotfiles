"""
" zettel.vim: minimal plugin for note-taking and zettelkasten
"

let g:ztl_notes_dir = expand($NOTES_DIR)
let g:ztl_zks_dir = g:ztl_notes_dir . '/zettelkasten/'

function! zettel#newzettel(...)

    " Args are the name of the zettel
    let l:varargs = a:000
    let l:sep = ''
    let l:timestamp = strftime("%F-%H%M")
    if len(l:varargs) > 0
        let l:sep = '_'
    endif

    " Construct the file name for the new zettel
    let l:fname = g:ztl_zks_dir . l:timestamp . l:sep . tolower(join(l:varargs, l:sep)) . '.ztl'

    " Edit the new file
    exe "e " . l:fname

    " create a header (yaml front matter)
    let l:title = join(l:varargs, ' ')
    let l:front_matter = [
        \'---',
        \'timestamp: ' . l:timestamp,
        \'tags:',
        \'  - #tag1',
        \'---',
        \'',
        \'',
        \'# ' . l:title,
    \]

    call append(line(0), l:front_matter)
endfunction

function! zettel#linksink(fzf_items)
    " Takes an fzf selected items and wraps it in a markdown link
    for l:fzf_item in a:fzf_items
        if len(l:fzf_item) == 0
            continue
        endif
        let l:fzf_item = split(l:fzf_item, ':')
        let l:fzf_item = substitute(l:fzf_item[0], g:ztl_zks_dir, './', '')
        call append(line('.'), "[" . l:fzf_item . "]")
    endfor
endfunction

" Create a new zettel, args are the title
" :ZtlNew this is my title
command! -nargs=* ZtlNew call zettel#newzettel(<f-args>)

" Search for one specific tag and open matches in quickfix list
command! -nargs=1 ZtlTagFiles execute 'silent grep! "^\s+-\s+\#<args>" '.g:ztl_notes_dir | copen | redraw!

let s:ripgrep_cmd = 'rg --column --line-number --no-heading --color=always --smart-case -- '
let s:fzf_opts = {'options': '--delimiter : --nth 4..'} " this makes fzf ignore matches in filename, only content
let s:fzf_opts_link = {'sink*': function('zettel#linksink')} " this makes fzf ignore matches in filename, only content
let s:fzf_preview_opts = 'right:40%'

" Fuzzy search for tags
command! -bang -nargs=0 ZtlTags
  \ call fzf#vim#grep(
  \   s:ripgrep_cmd . '"^\s+-\s+\#" ' . g:ztl_notes_dir , 1,
  \   fzf#vim#with_preview(s:fzf_opts, s:fzf_preview_opts), <bang>0
  \)

" Fuzzy search for content
command! -bang -nargs=* ZtlGrep
  \ call fzf#vim#grep(
  \   s:ripgrep_cmd . shellescape(<q-args>) . ' ' . g:ztl_notes_dir , 1,
  \   fzf#vim#with_preview(s:fzf_opts, s:fzf_preview_opts), <bang>0
  \)

command! -bang -nargs=* ZtlLink
  \ call fzf#vim#grep(
  \   s:ripgrep_cmd . shellescape(<q-args>) . ' ' . g:ztl_notes_dir , 1,
  \   fzf#vim#with_preview(extend(s:fzf_opts, s:fzf_opts_link), s:fzf_preview_opts), <bang>0
  \)

augroup zettel
   au!
   " Change dir when editing a note/zettel
   au BufRead,BufNewFile,BufEnter   $NOTES_DIR/**/*.* lcd %:h
augroup end
