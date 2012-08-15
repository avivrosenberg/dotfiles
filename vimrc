" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" =============== Pathogen Initialization ===============
" This loads all the plugins in ~/.vim/bundle
runtime bundle/tpope-vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup		" keep a backup file
set backupdir=~/.vimtmp " keep all backups in a separate folder
set backupext=.vimbackup
set noswapfile		" Don't create a swap file (everything in RAM)

set history=200		" keep n lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set showmode            " Show current mode down the bottom
set incsearch		" do incremental searching
set hlsearch 		" hilight current search pattern
set ignorecase		" case insensitive
set smartcase		" choose correct case when searching
set t_Co=256		" set 256 color suport
set number		" line numbers

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

colorscheme ir_black	" colors
syntax on

filetype plugin on
filetype indent on

" Autocommands
autocmd FileType php let b:surround_63 = "<?php \r ?>" "Use '?' (ascii 63) to surround with php tags.

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif
