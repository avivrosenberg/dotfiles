" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" =============== Pathogen Initialization ===============
" This loads all the plugins in ~/.vim/bundle
runtime bundle/tpope-vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

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

" Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Colors
set background=dark
colorscheme solarized                

" Autocommands
autocmd FileType php let b:surround_63 = "<?php \r ?>" "Use '?' (ascii 63) to surround with php tags.
autocmd FileType php,html,xml let b:surround_45 = "<!-- \r -->" "Use '-' (ascii 45) to surround with comment tags.
autocmd FileType ruby nmap <F5> :w<CR> :!ruby -w %<CR>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

if !has('gui_running')
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
