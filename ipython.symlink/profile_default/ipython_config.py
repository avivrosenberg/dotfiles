c = get_config()
c.TerminalInteractiveShell.confirm_exit = False

c.InteractiveShellApp.extensions = ['autoreload']  
c.InteractiveShellApp.exec_lines = ['%autoreload 2']
