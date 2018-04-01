# vim: ft=zsh

SYMBOL_BAD="✘"
RPROMPT_DEFAULT_COLOR="$fg[white]"

prompt_segment() {
    echo -n "%{\e[48;2;235;219;178m%} %{$reset_color%}%{$RPROMPT_DEFAULT_COLOR%}"
}

prompt_vi_mode() {
    if [ "$KEYMAP" = "main" ]; then
        echo -n "%{$bg[blue]$FG[000]%} INSERT "
    else
        echo -n "%{$bg[yellow]$FG[000]%} NORMAL "
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
            git_status_color=$fg[red]
        else
            git_status_color=$fg[green]
        fi

        echo -n " %{$git_status_color%}$(git_prompt_info)$(git_prompt_status) "
    fi
}

prompt_pwd() {
    echo -n " $(pwd | sed "s|$HOME|~|") "
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
    for command in prompt_vi_mode prompt_virtualenv prompt_git_status prompt_pwd; do
        prompt="`$command`"
        if [[ -n "$prompt" ]]; then
            prompt_segment
            $command
        fi
    done
    prompt_segment
    echo -n "%{$reset_color%}"
}

PROMPT='$(build_prompt)'
RPROMPT='$(build_rprompt)'
function zle-line-init zle-keymap-select {
    zle reset-prompt
}
