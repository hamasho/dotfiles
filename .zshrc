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
bindkey '^d' delete-char-or-list
bindkey '^t' history-search-backward
bindkey '^s' history-search-forward
bindkey '^g' insert-last-word
bindkey '^]' push-line-or-edit
bindkey '^\\' run-help
# replace command name
bindkey -s '^o' "^[0cE"
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
export SAVEHIST=$HISTSIZE
export LESS="-iRXF -j5"
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export NODE_PATH=${HOME}/.npm-global/lib/node_modules
export PATH=${HOME}/.npm-global/bin:$PATH
export PATH=${HOME}/.config/yarn/global/node_modules/.bin:$PATH
export PATH=${HOME}/.gem/ruby/2.4.0/bin:$PATH
export PATH=${HOME}/.local/bin:$PATH

alias -g C='--color=always | less'
alias -g H='--help | less'
alias -g J=' | jq -S . | less'
alias -g JC=' | jq -SC . | less'
alias -g L=' | less'
alias -g V='--version'
alias -g W='| w3m -T text/html'

alias gll='git log --no-color --graph --pretty="%h - %d %s (%cr) <%an>"'
alias ag="ag --color-match='1;33' --color-line-number='2;34;1' --color-path='1;35' --pager less"
alias gdiff='git diff --color-words --no-index --word-diff-regex=. --color=always'
alias glances='glances --process-short-name --byte'
alias open='2>/dev/null xdg-open'
alias ccat='pygmentize'
alias ca='calcurse'
alias tree='tree -I ".git|node_modules|__pycache__"'
alias http='http --style=rrt'
alias gs='glances'
alias p='ipython'
alias di='myougiden -w'

alias -g BR='$(git branch | peco | sed "s/\*//")'
alias -g BCMT='$(gll BR | peco | sed -E "s/^[*\\/| ]+(\w+) .*$/\1/")'
alias -g CMT='$(gll | peco | sed -E "s/^[*\\/| ]+(\w+) .*$/\1/")'

alias fzr='fzf --preview "cat {}"'
alias fzc='fzf --preview "pygmentize {} 2>&1 || cat {}"'
fzg() {
    # colorize matched pattern
    # usage: fzg PATTERN
    fzf --preview "egrep --color=always '$1|' {}"
}
# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
    local out file key
    IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
    key=$(head -1 <<< "$out")
    file=$(head -2 <<< "$out" | tail -1)
    if [ -n "$file" ]; then
        [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
    fi
}
# fuzzy grep open via ag
vg() {
    local file
    file="$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"
    if [[ -n $file ]]
    then
        vim $file
    fi
}

# fh - repeat history
function fh() {
    BUFFER=$( ([ -n "$ZSH_NAME" ] && fc -l -n 1 || history) \
        | tac \
        | perl -ne 'print unless $seen{$_}++' \
        | fzf +s --query="$LBUFFER")
    CURSOR=$#BUFFER
    zle -R -c
}
zle -N fh
bindkey '^r' fh

# fkill - kill process
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

# ftags - search ctags
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-80 | fzf --nth=1,2
  ) && ${EDITOR:-vim} $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}

if hash virtualenvwrapper_lazy.sh 2>&1; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/devel/repos
    export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    . `which virtualenvwrapper_lazy.sh`
fi

[[ -e /usr/share/z/z.sh ]] && . /usr/share/z/z.sh
[[ -e ~/.zshrc.local ]] && . ~/.zshrc.local

eval "$(fasd --init auto)"
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias j='fasd_cd -d'     # cd, same functionality as j in autojump
alias jj='fasd_cd -d -i' # cd with interactive selection

true
