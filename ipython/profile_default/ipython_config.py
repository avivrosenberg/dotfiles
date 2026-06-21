c = get_config()

c.TerminalInteractiveShell.confirm_exit = False

c.InteractiveShellApp.extensions = ["autoreload"]
c.InteractiveShellApp.exec_lines = ["%autoreload 2"]

# Keyboard shortcuts
c.TerminalInteractiveShell.shortcuts = [
    {
        "new_keys": ["c-g"],
        "command": "IPython:shortcuts.open_input_in_editor",
        "create": True,
    }
]
