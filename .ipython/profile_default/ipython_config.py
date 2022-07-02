import sys
import IPython

### INITIALIZE ###
c = get_config()
EXTENSIONS = []
EXEC_LINES = ['print()']


### CONFIGS ###

# simple start up banner
c.TerminalIPythonApp.display_banner = False

# not confirm exit
c.TerminalInteractiveShell.confirm_exit = False

# nomal key bindings
c.TerminalInteractiveShell.editing_mode = 'vi'

# set colors
c.TerminalInteractiveShell.colors = 'neutral'


### MODULES ###

# enable autoreload
EXTENSIONS.append('autoreload')
EXEC_LINES.extend(['%autoreload 2'])


### FINALIZE ###
c.InteractiveShellApp.extensions = EXTENSIONS
c.InteractiveShellApp.exec_lines = EXEC_LINES
