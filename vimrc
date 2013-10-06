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
set history=200                     " keep n lines of command line history
set ruler                           " show the cursor position all the time
set showcmd                         " display incomplete commands
set showmode                        " Show current mode down the bottom
set number                          " line numbers
set nowrap                          " don't wrap lines
set linebreak                       " wrap lines at convenient points
set backspace=indent,eol,start      " allow backspacing over everything in insert mode
syntax on                           " syntax highlighting

" Backup
set backup                          " keep a backup file
set backupdir=~/.vimtmp             " keep all backups in a separate folder
set backupext=.vimbackup            " set extention for backup files
set noswapfile                      " don't create a swap file (everything in RAM)

" Searching
set incsearch                       " do incremental searching
set hlsearch                        " hilight current search pattern
set ignorecase                      " case insensitive
set smartcase                       " choose correct case when searching

" General Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Ruby Indentation
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2

" Colors
set background=dark
colorscheme solarized                

" Ruby completion
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_load_gemfile = 1
let g:rubycomplete_use_bundler = 1

" Autocommands
autocmd FileType php let b:surround_63 = "<?php \r ?>" "Use '?' (ascii 63) to surround with php tags.
autocmd FileType php,html,xml let b:surround_45 = "<!-- \r -->" "Use '-' (ascii 45) to surround with comment tags.
autocmd FileType ruby nmap <F5> :w<CR> :!ruby -w %<CR>

" Key Maps
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Shortcuts for plugins
:let mapleader = "\\"
nmap <Leader>f :FufFileWithCurrentBufferDir<CR>
nmap <Leader>b :FufBuffer<CR>
nmap <Leader>t :NERDTreeToggle<CR>

" Fugitive
" This maps '..' to go back when browsing object with fugitive.
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
" Delete fugitive buffers on exit
autocmd BufReadPost fugitive://* set bufhidden=delete
" Add fugitive to status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

if !has('gui_running')
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
