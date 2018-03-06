import asyncio
from IPython import get_ipython
from IPython.terminal.prompts import Prompts, Token
from prompt_toolkit.keys import Keys
from prompt_toolkit.filters import ViInsertMode
from prompt_toolkit.key_binding.bindings.named_commands import get_by_name


ip = get_ipython()


## Prompt
class MyPrompt(Prompts):
    def in_prompt_tokens(self, cli=None):
        return [
            (Token.Prompt, '['),
            (Token.PromptNum, str(self.shell.execution_count)),
            (Token.Prompt, ']> '),
        ]

    def out_prompt_tokens(self, cli=None):
        return [
            (Token.OutPrompt, '['),
            (Token.OutPromptNum, str(self.shell.execution_count)),
            (Token.OutPrompt, ']: '),
        ]

ip.prompts = MyPrompt(ip)


## Keyboard Shortcuts
handle = ip.pt_cli.application.key_bindings_registry.add_binding
vi_ins = ViInsertMode()

# use emacs bindings in vi insert mode
handle(Keys.ControlA, filter=vi_ins)(get_by_name('beginning-of-line'))
handle(Keys.ControlB, filter=vi_ins)(get_by_name('backward-char'))
handle(Keys.ControlE, filter=vi_ins)(get_by_name('end-of-line'))
handle(Keys.ControlF, filter=vi_ins)(get_by_name('forward-char'))
handle(Keys.ControlK, filter=vi_ins)(get_by_name('kill-line'))
handle(Keys.ControlY, filter=vi_ins)(get_by_name('yank'))


##
## Util functions
##

def aw(future):
    '''Mock `await` keyword'''
    loop = asyncio.get_event_loop()
    return loop.run_until_complete(future)
