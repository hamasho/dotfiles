# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git python web-search tmux vi-mode zsh-completions zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search)

# initialize PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"
zstyle ':completion:*' list-prompt   ''
zstyle ':completion:*' select-prompt ''

source $ZSH/oh-my-zsh.sh

autoload -U compinit
compinit
zmodload -i zsh/complist

# User configuration

# set options
setopt extendedglob

# load my awesome theme
source ~/.my-theme.zsh-theme

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Stop send 'stop' signal
stty -ixon

# Enable Vi mode for line editing
bindkey -v
# Basic emacs keybinds in insert mode
bindkey '^p' up-line-or-history
bindkey '^n' down-line-or-history
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^b' backward-char
bindkey '^f' forward-char
bindkey '^k' kill-line
bindkey '^y' yank
bindkey '^z' undo
# Other keybinds
bindkey '^o' accept-line-and-down-history
bindkey '^r' history-incremental-search-backward
bindkey '^d' delete-char-or-list
bindkey '^t' history-search-backward
bindkey '^s' history-search-forward
bindkey '^g' insert-last-word
bindkey '^]' push-line-or-edit
bindkey '^\\' run-help
bindkey -s '^ve' "echo "
bindkey -s '^vl' "| less "
bindkey -s '^vg' "| grep "
bindkey -s '^vs' "| sed 's/'"
bindkey -s '^vo' "| sort "
# Enable to edit multi line script by <esc>v
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

export CLICOLOR=1
export TERM=xterm-256color
# export LS_COLORS="di=1;33:ln=34:fi=90:ex=32;1:or=1;36;41:mi=1;37;41"
export GREP_COLORS="fn=0;33"
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
[[ -d $HOME/bin ]]  && export PATH=$HOME/bin:$PATH
[[ -d $HOME/.bin ]] && export PATH=$HOME/.bin:$PATH
export HISTSIZE=2500000
export LESS="-iRXF -j5"
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
# export NODE_PATH=${HOME}/lib/npm_modules/lib/node_modules
# export PATH=${HOME}/lib/npm_modules/bin:$PATH
export PATH=${HOME}/.config/yarn/global/node_modules/.bin:$PATH
export PATH=${HOME}/.gem/ruby/2.4.0/bin:$PATH

alias -g C='--color=always | less'
alias -g H='--help | less'
alias -g J=' | jq -S . | less'
alias -g JC=' | jq -SC . | less'
alias -g L=' | less'
alias -g V='--version'
alias -g W='| w3m -T text/html'

alias gll='git log --no-color --graph --pretty="%h - %d %s (%cr) <%an>"'
alias -g BR='$(git branch | peco | sed "s/\*//")'
alias -g BCMT='$(gll BR | peco | sed -E "s/^[*\\/| ]+(\w+) .*$/\1/")'
alias -g CMT='$(gll | peco | sed -E "s/^[*\\/| ]+(\w+) .*$/\1/")'

alias ag="ag --color-match='1;32' --color-line-number='2;35;1' --color-path='1;31' --pager less"
alias gdiff='git diff --color-words --no-index --word-diff-regex=. --color=always'
alias .z='source ~/.zshrc'
alias glances='glances --process-short-name --byte'
alias open='2>/dev/null xdg-open'
alias fz='fzf --preview "pygmentize {} || cat {}"'
alias fzl='fzf --preview "cat {}"'
alias ccat='pygmentize'
alias ca='calcurse'
alias itree='tree -I ".git|node_modules|__pycache__"'
alias http='http --style=rrt'
hash thefuck 2> /dev/null && eval $(thefuck --alias)
# eval $(dircolors ~/.dircolors.solarized.light)

if hash virtualenvwrapper_lazy.sh 2>&1; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/devel/repos
    export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    . `which virtualenvwrapper_lazy.sh`
fi

[[ -e /usr/share/z/z.sh ]] && . /usr/share/z/z.sh
[[ -e ~/.zshrc.local ]] && . ~/.zshrc.local

true
