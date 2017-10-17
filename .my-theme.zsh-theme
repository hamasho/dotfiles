# vim: set ft=zsh

SYMBOL_BAD="✘"
RPROMPT_DEFAULT_COLOR="$fg[white]"

prompt_separator() {
    echo -n "%{$fg[white]%}│%{$reset_color%}%{$RPROMPT_DEFAULT_COLOR%}"
}

prompt_segment() {
    echo -n " $(prompt_separator) "
}

prompt_virtualenv() {
    [[ -z "$VIRTUAL_ENV" ]] && return
    prompt_segment
    echo -n "%{$fg[magenta]%}py%{$RPROMPT_DEFAULT_COLOR%}: $(basename $VIRTUAL_ENV)"
}

prompt_git_status() {
    local git_status_color

    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        prompt_segment

        if [[ -n $(git status --porcelain --ignore-submodules) ]]; then
            git_status_color=$fg[red]
        else
            git_status_color=$fg[green]
        fi

        echo -n "%{$git_status_color%}$(git_prompt_info)$(git_prompt_status)"
    fi
}

prompt_pwd() {
    prompt_segment
    echo -n $(pwd | sed "s@$HOME@~@")
}

build_prompt() {
    RETVAL=$?
    local color="$fg[cyan]"
    if [[ "$RETVAL" != "0" ]]; then
        color="$fg[red]"
        echo -n "%{$color%}$SYMBOL_BAD $RETVAL %{$reset_color%} "
    fi
    echo -n "%B>%b%{$color%}>%B>%b%{$reset_color%} "
}

build_rprompt() {
    prompt_virtualenv
    prompt_git_status
    prompt_pwd
    prompt_segment
}

# PROMPT="%B%{$fg[cyan]%}%(4~|%-1~/.../%2~|%~)%u%b >%{$fg[cyan]%}>%B%(?.%{$fg[cyan]%}.%{$fg[red]%})>%{$reset_color%}%b " # Print some system information when the shell is first started
PROMPT='$(build_prompt)'
RPROMPT='$(build_rprompt)'
