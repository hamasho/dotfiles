SYMBOL_BAD="✘"

prompt_segment() {
    echo -n " %{$bg[gray]%} %{$reset_color%} "
}

prompt_virtualenv() {
    echo -n venv
}

prompt_git_status() {
    echo -n git
}

prompt_pwd() {
    echo -n $(pwd)
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
    prompt_segment
    prompt_virtualenv
    prompt_segment
    prompt_git_status
    prompt_segment
    prompt_pwd
}

# PROMPT="%B%{$fg[cyan]%}%(4~|%-1~/.../%2~|%~)%u%b >%{$fg[cyan]%}>%B%(?.%{$fg[cyan]%}.%{$fg[red]%})>%{$reset_color%}%b " # Print some system information when the shell is first started
PROMPT='$(build_prompt)'
RPROMPT='$(build_rprompt)'
