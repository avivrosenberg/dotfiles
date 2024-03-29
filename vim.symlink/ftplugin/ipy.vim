" ftplugin for .ipy files
" These are just simply normal python files but I use them to send input
" to a running IPython process, so extra useful mappings (which are irrelavant
" for regular python files) are defined herein.
"


" Use the Built-in _EscapeText_python from vim-slime
" Just adding this custom function because the filetype
" of .ipy files will be python.ipy and not python.
function SlimeOverride_EscapeText_python_ipy(text)
    return _EscapeText_python(a:text)
endfunction

""""""""""""""""""""""""""""""
"  IPythonCell key mappings  "
""""""""""""""""""""""""""""""

" Start IPython
nnoremap <buffer> <Leader>S :SlimeSend1 ipython --matplotlib<CR>

" Run entire script
nnoremap <buffer> <Leader>R :w<CR>:IPythonCellRun<CR>

" Run script and time the execution
nnoremap <buffer> <Leader>T :w<CR>:IPythonCellRunTime<CR>

" map CTRL+ENTER and SHIFT+ENTER to execute the current cell without/with
" jumping to next cell.
" Note: These maps require a special setting in the terminal emulator
" to send the correct escape sequences (ESC + [13;2u for SHIFT+ENTER and
" ESC+[13;5u for CTRL+ENTER)
" see here: https://stackoverflow.com/a/42461580/1230403
" nnoremap <buffer> <C-CR> :IPythonCellExecuteCellVerbose<CR>
" inoremap <buffer> <C-CR> <Esc>:IPythonCellExecuteCellVerbose<CR>
" nnoremap <buffer> <S-CR> :IPythonCellExecuteCellVerboseJump<CR>
" inoremap <buffer> <S-CR> <Esc>:IPythonCellExecuteCellVerboseJump<CR>
nnoremap <buffer> <Leader>C :w<CR>:IPythonCellExecuteCellVerbose<CR>
inoremap <buffer> <Leader>C <Esc>:w<CR>:IPythonCellExecuteCellVerbose<CR>
nnoremap <buffer> <Leader>c :w<CR>:IPythonCellExecuteCellVerboseJump<CR>
inoremap <buffer> <Leader>c <Esc>:w<CR>:IPythonCellExecuteCellVerboseJump<CR>

" Clear IPython screen
nnoremap <buffer> <Leader>l :IPythonCellClear<CR>

" Close all Matplotlib figure windows
nnoremap <buffer> <Leader>x :IPythonCellClose<CR>

" Jump to the previous and next cell header like unimpaired
nnoremap <buffer> [[ :IPythonCellPrevCell<CR>
nnoremap <buffer> ]] :IPythonCellNextCell<CR>

" Send the current line or current selection to IPython
nmap <Leader><CR> <Plug>SlimeLineSend
xmap <Leader><CR> <Plug>SlimeRegionSend

" Run the previous command
nnoremap <buffer> <Leader>p :IPythonCellPrevCommand<CR>

" Restart ipython
nnoremap <buffer> <Leader>Q :IPythonCellRestart<CR>

" Start debug mode
nnoremap <buffer> <Leader>d :SlimeSend1 %debug<CR>
"
" Exit debug mode or IPython
nnoremap <buffer> <Leader>q :SlimeSend1 exit<CR>

" Insert cells
nmap <Leader>O :IPythonCellInsertAbove<CR>a
nmap <Leader>o :IPythonCellInsertBelow<CR>a
