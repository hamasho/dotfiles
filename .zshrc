# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# Set name of the theme to load in ~/.oh-my-zsh/themes/
# Optionally, "random" provide random themes each time you start zsh
#ZSH_THEME="my-bullet-train"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git python web-search tmux vi-mode zsh-completions zsh-syntax-highlighting)

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"
zstyle ':completion:*' list-prompt   ''
zstyle ':completion:*' select-prompt ''

source $ZSH/oh-my-zsh.sh

autoload -U compinit
compinit
zmodload -i zsh/complist

# User configuration

source ~/.my-theme.zsh-theme

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Stop send 'stop' signal
stty -ixon

# Enable Vi mode for line editing
bindkey -v
# Basic emacs keybinds
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
export PATH=$HOME/bin:$PATH
export HISTSIZE=25000
export LESS="-iRXF -j5"
export LANG=en_US.UTF-8
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

alias v=vim
alias ag="ag --color-match='1;32' --color-line-number='2;35;1' --color-path='1;31' --pager 'less -XF'"
alias .z='source ~/.zshrc'
alias .s='source ~/.shell-utility'
alias mutt='LC_CTYPE=ja_JP.utf8 mutt'
alias lynx='lynx -cfg=~/.lynx-cur/lynx.cfg -lss=~/.lynx-cur/lynx.lss google.com'
#alias lynx='lynx -cfg=~/.lynx-cur/lynx.cfg google.com'
alias nc='rlwrap nc'
alias gp='/usr/bin/gp -q'
alias ncat='rlwrap ncat'
alias telnet='rlwrap telnet'
alias info='info --vi-keys'
alias ngrep='sudo ngrep'
alias glances='glances --process-short-name --byte'
alias open='2>/dev/null xdg-open'
alias aps='apt-cache search'
alias apg='sudo apt-get install -y'
alias dic='sdcv'
alias memo='vim ~/doc/memo.md'
alias todo='vim ~/doc/todos.md'
alias gtd='vim ~/doc/gtd.md'
alias a='php artisan'
#alias php='php -dzend_extension=xdebug.so'
#alias phpunit='php $(which phpunit)'
alias pm='python3 manage.py'
alias tk='task project:endojo'
alias ca='calcurse'
alias tree='tree -I node_modules'
hash thefuck 2> /dev/null && eval $(thefuck --alias)
# eval $(dircolors ~/.dircolors.solarized.light)

if hash virtualenvwrapper_lazy.sh 2>&1; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/devel/repos
    export VIRTUALENVWRAPPER_PYTHON=`which python`
    export VIRTUALENVWRAPPER_VIRTUALENV=`which virtualenv`
    export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
    . `which virtualenvwrapper_lazy.sh`
fi

[[ -e /usr/share/z/z.sh ]] && . /usr/share/z/z.sh

[[ -e ~/.zshrc.private ]] && . ~/.zshrc.private
[[ -e ~/.zshrc.play ]]    && . ~/.zshrc.play
[[ -e ~/.shell-utility ]] && . ~/.shell-utility
