" pandoc-preview.vim - Minimal asynchronous pandoc previewer
"

if exists('g:loaded_pandoc_preview')
  finish
endif
let g:loaded_pandoc_preview = 1

let s:preview_running = 0

let g:pandoc_preview_pdf_cmd = get(g:, 'pandoc_preview_pdf_cmd', 'open -a Skim')
let g:pandoc_path = get(g:, 'pandoc_path', 'pandoc')
let g:pandoc_generate_pdf_dir = get(g:, 'pandoc_generate_pdf_dir', '/tmp')

"""
"
function! s:PandocGenerateFile()
    silent exec 'lcd %:p:h'
    if exists('g:pandoc_path')
        let response = system(printf("%s %s %s %s", 
                                        \shellescape(g:pandoc_path), 
                                        \'-o',
                                        \s:PdfFileName(),
                                        \shellescape(expand('%'))))
        if (match(response, 'Error') != -1)
            echo response
            return 1
        else
            return 0
        endif
    else
        return 0
    endif
endfunction

"""
" 
function! s:PdfFileName()
    return shellescape(((strlen(g:pandoc_generate_pdf_dir) == 0) ? expand('%:p:h') : g:pandoc_generate_pdf_dir).'/'.expand('%:t:r').'.pdf')
endfunction
 
"""
" 
function! s:PandocMarkdownPreview()
    silent exec 'lcd %:p:h'
    if (s:PandocGenerateFile() == 0) && exists('g:pandoc_preview_pdf_cmd')
        let pdf = s:PdfFileName()
        call system(printf("%s %s &", shellescape(g:pandoc_preview_pdf_cmd), pdf))
        echo pdf.' was generated.'
    
        augroup Preview
            autocmd!
            autocmd BufWritePost <buffer> call <SID>PandocGenerateFile()
        augroup END
    endif
endfunction

command! PandocCompile call <SID>PandocGenerateFile()
command! PandocPreview call <SID>PandocMarkdownPreview()

finish
