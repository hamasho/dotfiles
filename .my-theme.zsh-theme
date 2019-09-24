# vim: ft=zsh

PROMPT_CHAR=">"

POWERLINE_LEFT=""
SYMBOL_GOOD="✔"
SYMBOL_BAD="✘"
CURRENT_COLOR_NUM=0

# dark theme
# RPROMPT_COLORS=(241 239)

# light theme
RPROMPT_COLORS=(003 002 004 005)

prompt_vi_mode() {
    if [ "$KEYMAP" = "main" ]; then
        echo -n "%{$fg[blue]%}INS"
    else
        echo -n "%{$fg[green]%}NOR"
    fi
}

prompt_virtualenv() {
    local venv_name
    [[ -z "$VIRTUAL_ENV" ]] && return
    venv_name=$(basename $VIRTUAL_ENV)
    if (( ${#venv_name} > 6 )); then
        venv_name=$(echo "$venv_name" | sed 's/\(.....\).*$/\1../')
    fi
    echo -n "%{$fg[magenta]%}venv%{$fg[white]%}:${venv_name}"
}

prompt_git_status() {
    local git_branch git_status modified_files

    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        # Dont show anything if cwd is git-ignored
        git check-ignore --quiet . && return

        modified_files=$(git status --porcelain --ignore-submodules)
        if [[ -z "$modified_files" ]]; then
            git_status="%{$fg[green]%}${SYMBOL_GOOD}%{$fg[white]%}"
        else
            modified_files=$(echo $modified_files | wc -l)
            git_status="%{$fg[red]%}${SYMBOL_BAD}${modified_files}%{$fg[white]%}"
        fi

        git_branch=$(git rev-parse --abbrev-ref HEAD)
        if (( ${#git_branch} > 6 )); then
            git_branch=$(echo ${git_branch} | sed 's/\(.....\).*$/\1../')
        fi

        echo -n "${git_branch} ${git_status}"
    fi
}

prompt_pwd() {
    echo -n "$(pwd | sed "s|$HOME|~|" | sed "s|/\(...\)[^/]\+|/\1|g")"
}

build_prompt() {
    RETVAL=$?
    local color="$fg[magenta]"
    # check insert mode
    [ "$KEYMAP" = "main" ] && color="$fg[cyan]"
    if [[ "$RETVAL" != "0" ]]; then
        color="$fg[red]"
        echo -n "%{$color%}$SYMBOL_BAD $RETVAL %{$reset_color%}"
    fi
    echo -n "%B${PROMPT_CHAR}%b%{$color%}${PROMPT_CHAR}%B${PROMPT_CHAR}%b%{$reset_color%} "
}

rprompt_sector() {
    local result=$1 name=$2 c_color=$RPROMPT_COLORS[$(( CURRENT_COLOR_NUM + 1 ))]
    [[ -z "$result" ]] && return
    [[ -n "$name" ]] && result="${name}:${result}"
    result="%{$BG[$c_color]%}%{$FG[000]%} ${result} "
    echo -n "%{$FG[$c_color]%}${POWERLINE_LEFT}%b${result}"
    CURRENT_COLOR_NUM=$(( ! CURRENT_COLOR_NUM ))
}

build_rprompt() {
    # rprompt_sector "`prompt_vi_mode`"
    rprompt_sector "`prompt_virtualenv`"
    rprompt_sector "`prompt_git_status`"
    rprompt_sector "`prompt_pwd`"
    echo -n "%{$reset_color%}"
}

PROMPT='$(build_prompt)'
RPROMPT='$(build_rprompt)'
function zle-line-init zle-keymap-select {
    zle reset-prompt
}
