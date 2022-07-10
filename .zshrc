# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh
export ZSH_CUSTOM="${ZSH}/custom"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git python vi-mode aws docker)

if [[ -d "${ZSH_CUSTOM}/plugins/poetry" ]]; then
    plugins+=(poetry)
fi
if [[ -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]]; then
    plugins+=(zsh-autosuggestions)
else
    echo "No zsh-autosuggestions available! Install by the following command"
    echo "git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
if [[ -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]]; then
    plugins+=(zsh-syntax-highlighting)
else
    echo "No zsh-syntax-highlighting available! Install by the following command"
    echo "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [[ -x "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if hash tmux >/dev/null 2>&1; then
    plugins+=(tmux)
fi
if hash asdf >/dev/null 2>&1; then
    plugins+=(asdf)
fi

source $ZSH/oh-my-zsh.sh

autoload -U compinit
compinit
zmodload -i zsh/complist

# User configuration

# Set ZSH prompt theme
if hash starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# set options
setopt extendedglob
setopt HIST_FIND_NO_DUPS

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
bindkey '^g' insert-last-word
bindkey '^]' push-line-or-edit
bindkey '^\\' run-help
# replace command name
bindkey -s '^o' "^[0cE"
# Enable to edit multi line script by <esc>v
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

add_path() {
    [[ -d $1 ]] && export PATH=$1:$PATH
}

export CLICOLOR=1
export TERM=xterm-256color
# this TERM is customized one
# detail: https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
# export TERM=xterm-256color-italic
export EDITOR=nvim
export VISUAL=$EDITOR
if [[ $(uname) == Darwin ]]; then
    export BROWSER=/Applications/Firefox.app/Contents/MacOS/firefox-bin
else
    export BROWSER=/usr/bin/firefox
fi
# LSCOLORS is set somewhere but disable here to avoid confusion
unset LSCOLORS

add_path ${HOME}/Bin
export HISTSIZE=2500000
export SAVEHIST=$HISTSIZE
export LESS="-iRXF"
export BAT_OPTS="--theme=gruvbox-dark --style='numbers,header,grid' --wrap=never --italic-text=always"

export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

alias -g C='--color=always | less'
alias -g G='| ag'
alias -g GV='| ag -v'
alias -g H='2>&1 --help | less'
alias -g E='2>&1'
alias -g ON='>/dev/null'
alias -g EN='2>/dev/null'
alias -g AN='2>&1 >/dev/null'
alias -g J=' | jq -SC . | less'
alias -g L=' | LESS=-iR less'
alias -g V='--version'

alias agn='ag --nobreak --nofilename --nonumbers'
alias watch='watch --color '
alias gll='git log --no-color --graph --pretty="%h - %d %s (%cr) <%an>"'
alias gmmd='_CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD` && git checkout master && git merge $_CURRENT_BRANCH && git branch -d $_CURRENT_BRANCH'
alias gdiff='git diff --color-words --no-index --word-diff-regex=. --color=always'
alias gdiff2='git diff --color-words --no-index --color=always'
type open > /dev/null || alias open='2>/dev/null xdg-open'
alias tree='tree -I ".git|node_modules|__pycache__|venv|vendor"'
alias http='http --style=material'
alias gs='glances --process-short-name --byte'
alias p='ipython --colors=Linux'
alias nr='npm run'
alias yr='yarn run'

alias ag="ag --color-match='1;33' --color-line-number='1;34;1' --color-path='1;35' --pager less"
function _ag_raw_func() {
    ag --nofilename --nonumbers $@ | sort -u | sed '/^$/d'
}
alias agr=_ag_raw_func

[[ -d /usr/share/fzf ]] && . /usr/share/fzf/completion.zsh && . /usr/share/fzf/key-bindings.zsh
if [[ -d "${HOMEBREW_PREFIX}/opt/fzf/shell" ]]; then
    . "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh"
    . "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
fi
alias f-files='fzf --preview "bat --style=numbers --color=always {} 2>/dev/null"'
fzg() {
    # colorize matched pattern
    # usage: fzg PATTERN
    # pattern '$1|' means to show both of matched and unmatched lines
    fzf --preview "egrep --color=always '$1|' {}"
}
fzgg() {
    # colorize matched pattern, and only list matched files
    # usage: fzgg PATTERN
    ag -l "$1" | fzf --preview "egrep --color=always '$1|' {}"
}

# open file for view/edit
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
fag() {
    local file
    file="$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"
    if [[ -n $file ]]; then
        ${EDITOR:-vim} $file
    fi
}

alias -g BR='$(git branch | fzf | sed "s/\*//")'
alias -g BCMT='$(gll BR | fzf | sed -E "s/^[*\\/| ]+(\w+) .*$/\1/")'
alias -g CMT='$(gll | fzf | sed -E "s/^[*\\/| ]+(\w+) .*$/\1/")'
alias -g MF='$(git ls-files -m | fzf)'

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

alias pm="python manage.py"

if hash fasd >/dev/null 2>&1; then
    eval "$(fasd --init auto)"
    alias a='fasd -a'        # any
    alias s='fasd -si'       # show / search / select
    alias d='fasd -d'        # directory
    alias f='fasd -f'        # file
    alias sd='fasd -sid'     # interactive directory selection
    alias sf='fasd -sif'     # interactive file selection
    alias jj='fasd_cd -d -i' # cd with interactive selection
    # jump to directory fazy
    function j() {
        # alias j='fasd_cd -d'     # cd, same functionality as j in autojump
        fasd_cd -d "$@"
        pwd
    }
fi

export PYENV_ROOT="$HOME/.pyenv"
add_path ${PYENV_ROOT}/shims
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

wa() {
    local file="$1" ext err_msg="supported filetype: js, py, go"
    [[ -z "$1" ]] && echo "usage: wa FILENAME" && return 1
    ext="${file##*.}"
    [[ -z "$ext" ]] && echo "unsupported filename\n${err_msg}" && return 1
    case "$ext" in
        js)
            nodemon -w "${file}" -x "node ${file}"
            ;;
        py)
            nodemon -w "${file}" -x "python ${file}"
            ;;
        go)
            nodemon -w "${file}" -x "go run ${file}"
            ;;
        *)
            echo "unsupported filetype: ${ext}"
            echo "${err_msg}"
            return 1
            ;;
    esac
}

if hash direnv >/dev/null 2>&1 && hash asdf >/dev/null 2>&1; then
    eval "$(asdf exec direnv hook zsh)"
fi

# Prioritize locally installed python packages over asdf
add_path ${HOME}/.local/bin

add_path "${HOMEBREW_PREFIX}/opt/mysql-client/bin"

[[ -e ~/.zshrc.local ]] && . ~/.zshrc.local

export PATH="$HOME/.poetry/bin:$PATH"

[[ -e ~/.asdf/plugins/java/set-java-home.zsh ]] && \
    . ~/.asdf/plugins/java/set-java-home.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

