from IPython import get_ipython
from prompt_toolkit.key_binding import KeyBindings
from prompt_toolkit.keys import Keys
from prompt_toolkit.filters import vi_insert_mode

ip = get_ipython()

# Emacs-style keybindings in vi insert mode
kb = KeyBindings()

@kb.add(Keys.ControlA, filter=vi_insert_mode)
def _(event):
    event.current_buffer.cursor_position = 0

@kb.add(Keys.ControlE, filter=vi_insert_mode)
def _(event):
    event.current_buffer.cursor_position = len(event.current_buffer.text)

@kb.add(Keys.ControlB, filter=vi_insert_mode)
def _(event):
    event.current_buffer.cursor_position -= 1

@kb.add(Keys.ControlF, filter=vi_insert_mode)
def _(event):
    event.current_buffer.cursor_position += 1

@kb.add(Keys.ControlK, filter=vi_insert_mode)
def _(event):
    buffer = event.current_buffer
    buffer.delete(count=len(buffer.text) - buffer.cursor_position)

@kb.add(Keys.ControlY, filter=vi_insert_mode)
def _(event):
    event.current_buffer.paste_clipboard_data(event.app.clipboard.get_data())

ip.pt_app.key_bindings = kb
