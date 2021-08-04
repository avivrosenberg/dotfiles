" Define compound filetype python.ipy
" This means that the python ftplugin files will be used, then the ipy
" ftplugins (which are custom)
au BufRead,BufNewFile *.ipy		setfiletype python.ipy
