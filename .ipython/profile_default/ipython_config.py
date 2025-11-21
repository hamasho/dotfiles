# IPython configuration
c = get_config()

# UI preferences
c.TerminalIPythonApp.display_banner = False
c.TerminalInteractiveShell.confirm_exit = False
c.TerminalInteractiveShell.editing_mode = 'vi'
c.TerminalInteractiveShell.colors = 'neutral'

# Auto-reload modules before executing code
c.InteractiveShellApp.extensions = ['autoreload']
c.InteractiveShellApp.exec_lines = ['%autoreload 2']
