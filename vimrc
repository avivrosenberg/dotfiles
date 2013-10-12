" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" =============== Pathogen Initialization ===============
" This loads all the plugins in ~/.vim/bundle
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
execute pathogen#helptags()

filetype plugin on
filetype indent on

" General VIM settings
set ruler                           " show the cursor position all the time
set showcmd                         " display incomplete commands
set showmode                        " Show current mode down the bottom
set number                          " line numbers
set nowrap                          " don't wrap lines
set linebreak                       " wrap lines at convenient points
set backspace=indent,eol,start      " allow backspacing over everything in insert mode
set hidden                          " allow hiding buffers with changes
syntax on                           " syntax highlighting

" Backup
set history=1000                    " keep n lines of command line history
set undolevels=1000                 " lots of undo power
set wildignore=*.swp,*.bak          " extensions to ignore when expanding wildcards
set backup                          " keep a backup file
set backupdir=~/.vimtmp             " keep all backups in a separate folder
set backupext=.vimbackup            " set extention for backup files
set noswapfile                      " don't create a swap file (everything in RAM)

" Searching
set incsearch                       " do incremental searching
set hlsearch                        " hilight current search pattern
set ignorecase                      " case insensitive
set smartcase                       " choose correct case when searching
set gdefault                        " global substitution default
nnoremap / /\v
vnoremap / /\v

" General Indentation
set autoindent
set copyindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set shiftround
set expandtab

" Colors
set background=dark
colorscheme solarized                

" Ruby completion
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_load_gemfile = 1
let g:rubycomplete_use_bundler = 1

" Ruby debugging
let g:ruby_debugger_progname = 'mvim'
let g:ruby_debugger_no_maps = 1
let g:ruby_debugger_builtin_sender = 0
let g:ruby_debugger_debug_mode = 1
map <Leader>rb  :call g:RubyDebugger.toggle_breakpoint()<CR>
map <Leader>rv  :call g:RubyDebugger.open_variables()<CR>
map <Leader>rm  :call g:RubyDebugger.open_breakpoints()<CR>
map <Leader>rt  :call g:RubyDebugger.open_frames()<CR>
map <Leader>rs  :call g:RubyDebugger.step()<CR>
map <Leader>rf  :call g:RubyDebugger.finish()<CR>
map <Leader>rn  :call g:RubyDebugger.next()<CR>
map <Leader>rc  :call g:RubyDebugger.continue()<CR>
map <Leader>re  :call g:RubyDebugger.exit()<CR>
map <Leader>rd  :call g:RubyDebugger.remove_breakpoints()<CR>

" Autocommands for Ruby
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2 "ruby indentation
autocmd Filetype ruby setlocal foldmethod=syntax "indent one less than max
autocmd Filetype ruby normal zR
autocmd FileType ruby nmap <F5> :w<CR> :!ruby -w %<CR>
"autocmd BufEnter *.rb Rvm " automatically switch Ruby versions when switching buffers

" Leader Shortcuts 
:let mapleader = "\\"
nmap <Leader>ff :FufFileWithCurrentBufferDir<CR>
nmap <Leader>fb :FufBuffer<CR>
nmap <Leader>fmf :FufBookmarkFile<CR>
nmap <Leader>fmd :FufBookmarkDir<CR>
nmap <Leader>tt :NERDTreeToggle<CR>
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gd :Gdiff<CR>
nmap <Leader><Space> :nohl<CR>

" Key Maps
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <Leader>ct :!ctags -R --exclude=.git --exclude=logs --exclude=doc .<CR>

" Fugitive
" This maps '..' to go back when browsing object with fugitive.
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
" Delete fugitive buffers on exit
autocmd BufReadPost fugitive://* set bufhidden=delete

" Status line: fugitive and rvm
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%{rvm#statusline()}%=%-14.(%l,%c%V%)\ %P

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

if !has('gui_running')
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
