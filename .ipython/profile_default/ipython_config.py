# not confirm exit
c.TerminalInteractiveShell.confirm_exit = False

# auto reload module
c.InteractiveShellApp.extensions = ['autoreload']
c.InteractiveShellApp.exec_lines = ['%autoreload 2']
c.InteractiveShellApp.exec_lines.append(
    'print("Warning: disable autoreload to get better performance")',
)
