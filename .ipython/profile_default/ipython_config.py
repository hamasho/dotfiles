import sys
import IPython

### INITIALIZE ###
c = get_config()
EXTENSIONS = []
EXEC_LINES = ['print()']


### CONFIGS ###

# simple start up banner
c.TerminalInteractiveShell.banner1 = (
    "Python %s, IPython %s. (type '?' for help)" % (
        sys.version.split()[0], IPython.__version__,
    )
)

# not confirm exit
c.TerminalInteractiveShell.confirm_exit = False

# nomal key bindings
c.TerminalInteractiveShell.editing_mode = 'vi'


### MODULES ###

# enable autoreload
EXTENSIONS.append('autoreload')
EXEC_LINES.extend([
    '%autoreload 2',
    'print("warn: disable autoreload for better performance (\\"%autoreload 1\\")")',
])


### FINALIZE ###
c.InteractiveShellApp.extensions = EXTENSIONS
c.InteractiveShellApp.exec_lines = EXEC_LINES
