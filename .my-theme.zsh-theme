# vim: ft=zsh

SYMBOL_BAD="✘"
RPROMPT_DEFAULT_COLOR="$fg[white]"

prompt_vi_mode() {
    if [ "$KEYMAP" = "main" ]; then
        echo -n "%{$bg[blue]$FG[015]%} vi:INS "
    else
        echo -n "%{$bg[yellow]$FG[015]%} vi:NORM "
    fi
}

prompt_virtualenv() {
    [[ -z "$VIRTUAL_ENV" ]] && return
    echo -n " %{$fg[magenta]%}py%{$RPROMPT_DEFAULT_COLOR%}: $(basename $VIRTUAL_ENV) "
}

prompt_git_status() {
    local git_status_color

    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        # Dont show anything if cwd is git-ignored
        git check-ignore --quiet . && return

        if [[ -n $(git status --porcelain --ignore-submodules) ]]; then
            git_status_color=$BG[166]
        else
            git_status_color=$bg[green]
        fi

        echo -n "%{$git_status_color$FG[015]%} $(git_prompt_info)$(git_prompt_status) "
    fi
}

prompt_pwd() {
    echo -n "%{$bg[blue]%} $(pwd | sed "s|$HOME|~|" | sed "s|/\(...\)[^/]\+|/\1|g") "
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
    local command
    local prompt
    for command in prompt_virtualenv prompt_git_status prompt_pwd; do
        prompt="`$command`"
        if [[ -n "$prompt" ]]; then
            $command
        fi
    done
    echo -n "%{$reset_color%}"
}

PROMPT='$(build_prompt)'
RPROMPT='$(build_rprompt)'
function zle-line-init zle-keymap-select {
    zle reset-prompt
}
