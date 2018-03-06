# vim: ft=zsh

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
    local FILE=/tmp/.ignore_git_prompt_dirs
    local dir
    local start_time="$(date '+%s').$(date '+%N')"
    local end_time total

    if [[ -f $FILE ]]; then
        while read dir; do
            if [[ $PWD = $dir ]]; then
                prompt_segment
                echo -n "%{$fg[cyan]%}skip!"
                return
            fi
        done < $FILE
    fi

    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        # Dont show anything if cwd is git-ignored
        git check-ignore --quiet . && return

        prompt_segment

        if [[ -n $(git status --porcelain --ignore-submodules) ]]; then
            git_status_color=$fg[red]
        else
            git_status_color=$fg[green]
        fi

        echo -n "%{$git_status_color%}$(git_prompt_info)$(git_prompt_status)"
    fi

    end_time="$(date '+%s').$(date '+%N')"
    # total=$(echo $(( $end_time - $start_time )) | bc)
    # if (( $total > 0.3 )); then
    #     echo $PWD >> $FILE
    # fi
}

prompt_pwd() {
    prompt_segment
    echo -n $(shortest_path_display "$PWD")
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
    [[ $PWD =~ $HOME/works/osx_works ]] && return
    prompt_virtualenv
    prompt_git_status
    prompt_pwd
    prompt_segment
    echo -n "%{$reset_color%}"
}

# PROMPT="%B%{$fg[cyan]%}%(4~|%-1~/.../%2~|%~)%u%b >%{$fg[cyan]%}>%B%(?.%{$fg[cyan]%}.%{$fg[red]%})>%{$reset_color%}%b " # Print some system information when the shell is first started
PROMPT='$(build_prompt)'
RPROMPT='$(build_rprompt)'
