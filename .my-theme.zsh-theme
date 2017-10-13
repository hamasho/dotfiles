# README
#
# This theme is based on Caio Gondim's bullet train theme.
# (https://github.com/caiogondim/bullet-train-oh-my-zsh-theme)
#
# Licence: MIT

VIRTUAL_ENV_DISABLE_PROMPT=true

# ---- MY SETTINGS ----

# -- TITLE --

case "${TERM}" in
  ?term*|rxvt*|screen) PROMPT_COMMAND='echo -ne "\033]0;$0@${HOSTNAME:=$(hostname)}: ${PWD/$HOME/"~"}\007"';;
esac

# -- PROMPT --

[[ -d /tmp/.bullettrain ]] || mkdir /tmp/.bullettrain
tmpfile_basecolor=/tmp/.bullettrain/basecolor"$(tty | sed 's|/|.|g')"

# Prompt previous command execution time
initialize_color() {
    MY_THEME_SWITCH=0
    if [[ ! -f ${tmpfile_basecolor} ]]; then
        echo $MY_THEME_SWITCH > ${tmpfile_basecolor}
    fi
    MY_THEME_SWITCH=$(cat ${tmpfile_basecolor})
    if [[ $MY_THEME_SWITCH == 0 ]]; then
        # COLOR 1 (GREEN)
        MY_THEME_BG1=118
        MY_THEME_BG2=155
        MY_THEME_BG3=076
        MY_THEME_BG4=034
    elif [[ $MY_THEME_SWITCH == 1 ]]; then
        # COLOR 2 (BLUE)
        MY_THEME_BG1=051
        MY_THEME_BG2=123
        MY_THEME_BG3=045
        MY_THEME_BG4=033
    elif [[ $MY_THEME_SWITCH == 2 ]]; then
        # COLOR 3 (RED)
        MY_THEME_BG1=219
        MY_THEME_BG2=213
        MY_THEME_BG3=206
    elif [[ $MY_THEME_SWITCH == 3 ]]; then
        # COLOR 3 (ORANGE)
        MY_THEME_BG1=226
        MY_THEME_BG2=220
        MY_THEME_BG3=214
        MY_THEME_BG4=208
    else
        echo "SOMETHING WRONG IS HAPPEND IN MY-THEME.ZSH-THEME!!!"
    fi
    MY_THEME_FG=000
    echo $(( (MY_THEME_SWITCH + 1) % 4 )) > ${tmpfile_basecolor}
    BULLETTRAIN_STATUS_BG=$MY_THEME_BG1
    BULLETTRAIN_STATUS_FG=$MY_THEME_FG
    BULLETTRAIN_EXEC_TIME_BG=$MY_THEME_BG2
    BULLETTRAIN_EXEC_TIME_FG=$MY_THEME_FG
    BULLETTRAIN_DIR_BG=$MY_THEME_BG3
    BULLETTRAIN_DIR_FG=$MY_THEME_FG
    BULLETTRAIN_PROMPT_BG=$MY_THEME_BG4
}

if [[ -z "$BULLETTRAIN_BASE_COLOR" ]]; then
  BULLETTRAIN_BASE_COLOR=254
fi
if [[ $BULLETTRAIN_BASE_COLOR == 254 ]]; then
  BULLETTRAIN_BASE_COLOR=$(($BULLETTRAIN_BASE_COLOR - 2))
else
  BULLETTRAIN_BASE_COLOR=$(($BULLETTRAIN_BASE_COLOR + 2))
fi
BULLETTRAIN_PROMPT_ADD_NEWLINE=false
BULLETTRAIN_PROMPT_SEPARATE_LINE=false
BULLETTRAIN_PROMPT_CHAR=''
BULLETTRAIN_TIME_SHOW=false
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_STATUS_BG=$(($BULLETTRAIN_BASE_COLOR))
BULLETTRAIN_EXEC_TIME_SHOW=true
BULLETTRAIN_EXEC_TIME_ELAPSED=-1
BULLETTRAIN_EXEC_TIME_BG=$(($BULLETTRAIN_BASE_COLOR - 2))
BULLETTRAIN_DIR_EXTENDED=1
BULLETTRAIN_DIR_BG=$(($BULLETTRAIN_BASE_COLOR - 4))
BULLETTRAIN_GIT_SHOW=false
BULLETTRAIN_PROMPT_BG=$(($BULLETTRAIN_BASE_COLOR - 6))

BULLETTRAIN_GIT_FG=244
BULLETTRAIN_GIT_BG=NONE
BULLETTRAIN_GIT_PROMPT_CMD="\$(git_prompt_info)"
BULLETTRAIN_RIGHT_GIT_SHOW=true
BULLETTRAIN_RIGHT_SEPARATOR_FG=249
# BULLETTRAIN_RIGHT_SEPARATOR_BG=251

# ---------------------
# My Function
prompt_status() {
  if [[ $BULLETTRAIN_STATUS_SHOW == false ]]; then
    return
  fi

  local symbols
  symbols=()
  RETVAL=$(printf %03d $RETVAL)
  [[ $RETVAL -ne 0 ]] && symbols+="%F{red}✘%F{$BULLETTRAIN_STATUS_FG}"
  [[ $RETVAL = 000 ]] && symbols+="%F{064}✔%F{$BULLETTRAIN_STATUS_FG}"
  # symbols+="$RETVAL"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="⚙"

  prompt_segment $BULLETTRAIN_STATUS_BG $BULLETTRAIN_STATUS_FG "$symbols"
}
prompt_dir() {
  if [[ $BULLETTRAIN_DIR_SHOW == false ]]; then
    return
  fi

  local dir="$(\pwd)"
  dir=$(echo "${dir}" | sed 's|/home/shinsuke|~|')
  dir=$(echo "${dir}" | sed 's|/\([^/]\{3\}\)[^/]*|/\1|g')
  prompt_segment $BULLETTRAIN_DIR_BG $BULLETTRAIN_DIR_FG $dir
}

# PROMPT
if [ ! -n "${BULLETTRAIN_PROMPT_CHAR+1}" ]; then
  BULLETTRAIN_PROMPT_CHAR="\$"
fi
if [ ! -n "${BULLETTRAIN_PROMPT_ROOT+1}" ]; then
  BULLETTRAIN_PROMPT_ROOT=true
fi
if [ ! -n "${BULLETTRAIN_PROMPT_SEPARATE_LINE+1}" ]; then
  BULLETTRAIN_PROMPT_SEPARATE_LINE=true
fi
if [ ! -n "${BULLETTRAIN_PROMPT_ADD_NEWLINE+1}" ]; then
  BULLETTRAIN_PROMPT_ADD_NEWLINE=true
fi

# STATUS
if [ ! -n "${BULLETTRAIN_STATUS_SHOW+1}" ]; then
  BULLETTRAIN_STATUS_SHOW=true
fi
if [ ! -n "${BULLETTRAIN_STATUS_EXIT_SHOW+1}" ]; then
  BULLETTRAIN_STATUS_EXIT_SHOW=false
fi
if [ ! -n "${BULLETTRAIN_STATUS_BG+1}" ]; then
  BULLETTRAIN_STATUS_BG=green
fi
if [ ! -n "${BULLETTRAIN_STATUS_ERROR_BG+1}" ]; then
  BULLETTRAIN_STATUS_ERROR_BG=red
fi
if [ ! -n "${BULLETTRAIN_STATUS_FG+1}" ]; then
  BULLETTRAIN_STATUS_FG=white
fi

# TIME
if [ ! -n "${BULLETTRAIN_TIME_SHOW+1}" ]; then
  BULLETTRAIN_TIME_SHOW=true
fi
if [ ! -n "${BULLETTRAIN_TIME_BG+1}" ]; then
  BULLETTRAIN_TIME_BG=white
fi
if [ ! -n "${BULLETTRAIN_TIME_FG+1}" ]; then
  BULLETTRAIN_TIME_FG=black
fi

# CUSTOM
if [ ! -n "${BULLETTRAIN_CUSTOM_MSG+1}" ]; then
  BULLETTRAIN_CUSTOM_MSG=false
fi
if [ ! -n "${BULLETTRAIN_CUSTOM_BG+1}" ]; then
  BULLETTRAIN_CUSTOM_BG=black
fi
if [ ! -n "${BULLETTRAIN_CUSTOM_FG+1}" ]; then
  BULLETTRAIN_CUSTOM_FG=default
fi

# VIRTUALENV
if [ ! -n "${BULLETTRAIN_VIRTUALENV_SHOW+1}" ]; then
  BULLETTRAIN_VIRTUALENV_SHOW=true
fi
if [ ! -n "${BULLETTRAIN_VIRTUALENV_BG+1}" ]; then
  BULLETTRAIN_VIRTUALENV_BG=yellow
fi
if [ ! -n "${BULLETTRAIN_VIRTUALENV_FG+1}" ]; then
  BULLETTRAIN_VIRTUALENV_FG=white
fi
if [ ! -n "${BULLETTRAIN_VIRTUALENV_PREFIX+1}" ]; then
  BULLETTRAIN_VIRTUALENV_PREFIX=🐍
fi

# NVM
if [ ! -n "${BULLETTRAIN_NVM_SHOW+1}" ]; then
  BULLETTRAIN_NVM_SHOW=false
fi
if [ ! -n "${BULLETTRAIN_NVM_BG+1}" ]; then
  BULLETTRAIN_NVM_BG=green
fi
if [ ! -n "${BULLETTRAIN_NVM_FG+1}" ]; then
  BULLETTRAIN_NVM_FG=white
fi
if [ ! -n "${BULLETTRAIN_NVM_PREFIX+1}" ]; then
  BULLETTRAIN_NVM_PREFIX="⬡ "
fi

# RUBY
if [ ! -n "${BULLETTRAIN_RUBY_SHOW+1}" ]; then
  BULLETTRAIN_RUBY_SHOW=true
fi
if [ ! -n "${BULLETTRAIN_RUBY_BG+1}" ]; then
  BULLETTRAIN_RUBY_BG=magenta
fi
if [ ! -n "${BULLETTRAIN_RUBY_FG+1}" ]; then
  BULLETTRAIN_RUBY_FG=white
fi
if [ ! -n "${BULLETTRAIN_RUBY_PREFIX+1}" ]; then
  BULLETTRAIN_RUBY_PREFIX=♦️
fi

# Go
if [ ! -n "${BULLETTRAIN_GO_SHOW+1}" ]; then
  BULLETTRAIN_GO_SHOW=false
fi
if [ ! -n "${BULLETTRAIN_GO_BG+1}" ]; then
  BULLETTRAIN_GO_BG=cyan
fi
if [ ! -n "${BULLETTRAIN_GO_FG+1}" ]; then
  BULLETTRAIN_GO_FG=white
fi
if [ ! -n "${BULLETTRAIN_GO_PREFIX+1}" ]; then
  BULLETTRAIN_GO_PREFIX="go "
fi

# DIR
if [ ! -n "${BULLETTRAIN_DIR_SHOW+1}" ]; then
  BULLETTRAIN_DIR_SHOW=true
fi
if [ ! -n "${BULLETTRAIN_DIR_BG+1}" ]; then
  BULLETTRAIN_DIR_BG=blue
fi
if [ ! -n "${BULLETTRAIN_DIR_FG+1}" ]; then
  BULLETTRAIN_DIR_FG=white
fi
if [ ! -n "${BULLETTRAIN_DIR_CONTEXT_SHOW+1}" ]; then
  BULLETTRAIN_DIR_CONTEXT_SHOW=false
fi
if [ ! -n "${BULLETTRAIN_DIR_EXTENDED+1}" ]; then
  BULLETTRAIN_DIR_EXTENDED=1
fi

# GIT
if [ ! -n "${BULLETTRAIN_GIT_SHOW+1}" ]; then
  BULLETTRAIN_GIT_SHOW=true
fi
if [ ! -n "${BULLETTRAIN_GIT_COLORIZE_DIRTY+1}" ]; then
  BULLETTRAIN_GIT_COLORIZE_DIRTY=false
fi
if [ ! -n "${BULLETTRAIN_GIT_COLORIZE_DIRTY_COLOR+1}" ]; then
  BULLETTRAIN_GIT_COLORIZE_DIRTY_COLOR=yellow
fi
if [ ! -n "${BULLETTRAIN_GIT_BG+1}" ]; then
  BULLETTRAIN_GIT_BG=white
fi
if [ ! -n "${BULLETTRAIN_GIT_FG+1}" ]; then
  BULLETTRAIN_GIT_FG=black
fi
if [ ! -n "${BULLETTRAIN_GIT_EXTENDED+1}" ]; then
  BULLETTRAIN_GIT_EXTENDED=true
fi
if [ ! -n "${BULLETTRAIN_GIT_PROMPT_CMD+1}" ]; then
  BULLETTRAIN_GIT_PROMPT_CMD="\$(git_prompt_info)"
fi

# HG
if [ ! -n "${BULLETTRAIN_HG_SHOW+1}" ]; then
  BULLETTRAIN_HG_SHOW=true
fi

# CONTEXT
if [ ! -n "${BULLETTRAIN_CONTEXT_SHOW+1}" ]; then
  BULLETTRAIN_CONTEXT_SHOW=false
fi
if [ ! -n "${BULLETTRAIN_CONTEXT_BG+1}" ]; then
  BULLETTRAIN_CONTEXT_BG=black
fi
if [ ! -n "${BULLETTRAIN_CONTEXT_FG+1}" ]; then
  BULLETTRAIN_CONTEXT_FG=default
fi

# GIT PROMPT
if [ ! -n "${BULLETTRAIN_GIT_PREFIX+1}" ]; then
  ZSH_THEME_GIT_PROMPT_PREFIX=" \ue0a0 "
else
  ZSH_THEME_GIT_PROMPT_PREFIX=$BULLETTRAIN_GIT_PREFIX
fi
if [ ! -n "${BULLETTRAIN_GIT_SUFFIX+1}" ]; then
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
else
  ZSH_THEME_GIT_PROMPT_SUFFIX=$BULLETTRAIN_GIT_SUFFIX
fi
if [ ! -n "${BULLETTRAIN_GIT_DIRTY+1}" ]; then
  ZSH_THEME_GIT_PROMPT_DIRTY=" ✘"
else
  ZSH_THEME_GIT_PROMPT_DIRTY=$BULLETTRAIN_GIT_DIRTY
fi
if [ ! -n "${BULLETTRAIN_GIT_CLEAN+1}" ]; then
  ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"
else
  ZSH_THEME_GIT_PROMPT_CLEAN=$BULLETTRAIN_GIT_CLEAN
fi
if [ ! -n "${BULLETTRAIN_GIT_ADDED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_ADDED=" %F{green}✚%F{black}"
else
  ZSH_THEME_GIT_PROMPT_ADDED=$BULLETTRAIN_GIT_ADDED
fi
if [ ! -n "${BULLETTRAIN_GIT_MODIFIED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_MODIFIED=" %F{blue}✹%F{black}"
else
  ZSH_THEME_GIT_PROMPT_MODIFIED=$BULLETTRAIN_GIT_MODIFIED
fi
if [ ! -n "${BULLETTRAIN_GIT_DELETED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_DELETED=" %F{red}✖%F{black}"
else
  ZSH_THEME_GIT_PROMPT_DELETED=$BULLETTRAIN_GIT_DELETED
fi
if [ ! -n "${BULLETTRAIN_GIT_UNTRACKED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_UNTRACKED=" %F{yellow}✭%F{black}"
else
  ZSH_THEME_GIT_PROMPT_UNTRACKED=$BULLETTRAIN_GIT_UNTRACKED
fi
if [ ! -n "${BULLETTRAIN_GIT_RENAMED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
else
  ZSH_THEME_GIT_PROMPT_RENAMED=$BULLETTRAIN_GIT_RENAMED
fi
if [ ! -n "${BULLETTRAIN_GIT_UNMERGED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
else
  ZSH_THEME_GIT_PROMPT_UNMERGED=$BULLETTRAIN_GIT_UNMERGED
fi
if [ ! -n "${BULLETTRAIN_GIT_AHEAD+1}" ]; then
  ZSH_THEME_GIT_PROMPT_AHEAD=" ⬆"
else
  ZSH_THEME_GIT_PROMPT_AHEAD=$BULLETTRAIN_GIT_AHEAD
fi
if [ ! -n "${BULLETTRAIN_GIT_BEHIND+1}" ]; then
  ZSH_THEME_GIT_PROMPT_BEHIND=" ⬇"
else
  ZSH_THEME_GIT_PROMPT_BEHIND=$BULLETTRAIN_GIT_BEHIND
fi
if [ ! -n "${BULLETTRAIN_GIT_DIVERGED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_DIVERGED=" ⬍"
else
  ZSH_THEME_GIT_PROMPT_DIVERGED=$BULLETTRAIN_GIT_PROMPT_DIVERGED
fi

# COMMAND EXECUTION TIME
if [ ! -n "${BULLETTRAIN_EXEC_TIME_SHOW+1}" ]; then
  BULLETTRAIN_EXEC_TIME_SHOW=false
fi
if [ ! -n "${BULLETTRAIN_EXEC_TIME_ELAPSED+1}" ]; then
  BULLETTRAIN_EXEC_TIME_ELAPSED=5
fi
if [ ! -n "${BULLETTRAIN_EXEC_TIME_BG+1}" ]; then
  BULLETTRAIN_EXEC_TIME_BG=yellow
fi
if [ ! -n "${BULLETTRAIN_EXEC_TIME_FG+1}" ]; then
  BULLETTRAIN_EXEC_TIME_FG=black
fi


# ------------------------------------------------------------------------------
# SEGMENT DRAWING
# A few functions to make it easy and re-usable to draw segmented prompts
# ------------------------------------------------------------------------------

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''
#SEGMENT_SEPARATOR='⮀'

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

# My Configration
__prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%K{$BULLETTRAIN_PROMPT_BG}%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    echo -n "%{%k%F{$BULLETTRAIN_PROMPT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  CURRENT_BG=''
}
rprompt_separator() {
  echo -n "%{%K{$BULLETTRAIN_RIGHT_SEPARATOR_BG}%F{$BULLETTRAIN_RIGHT_SEPARATOR_FG}%} "
}
# ----------------

# ------------------------------------------------------------------------------
# PROMPT COMPONENTS
# Each component will draw itself, and hide itself if no information needs
# to be shown
# ------------------------------------------------------------------------------

# Context: user@hostname (who am I and where am I)
context() {
  local user="$(whoami)"
  [[ "$user" != "$BULLETTRAIN_CONTEXT_DEFAULT_USER" || -n "$BULLETTRAIN_IS_SSH_CLIENT" ]] && echo -n "${user}@%m"
}
prompt_context() {
  [[ $BULLETTRAIN_CONTEXT_SHOW == false ]] && return

  local _context="$(context)"
  [[ -n "$_context" ]] && prompt_segment $BULLETTRAIN_CONTEXT_BG $BULLETTRAIN_CONTEXT_FG "$_context"
}

tmpfile_exectime=/tmp/.bullettrain/preexec"$(tty | sed 's|/|.|g')"

preexec() {
    cmd_timestamp=`date +%s`
    echo 'true' > ${tmpfile_exectime}
}

prompt_cmd_exec_time() {
  if [[ $BULLETTRAIN_EXEC_TIME_SHOW == false ]]; then
    return
  fi

  local stop=`date +%s`
  local start=${cmd_timestamp:-$stop}
  let local elapsed=$stop-$start

  if [[ -f ${tmpfile_exectime} && $(cat ${tmpfile_exectime}) == true ]]; then
    [ $elapsed -gt $BULLETTRAIN_EXEC_TIME_ELAPSED ] && prompt_segment $BULLETTRAIN_EXEC_TIME_BG $BULLETTRAIN_EXEC_TIME_FG "${elapsed}s"
    echo false > ${tmpfile_exectime}
  else
    prompt_segment $BULLETTRAIN_EXEC_TIME_BG $BULLETTRAIN_EXEC_TIME_FG "0s"
  fi
}

# Custom
prompt_custom() {
  if [[ $BULLETTRAIN_CUSTOM_MSG == false ]]; then
    return
  fi

  prompt_segment $BULLETTRAIN_CUSTOM_BG $BULLETTRAIN_CUSTOM_FG "${BULLETTRAIN_CUSTOM_MSG}"
}

# Git
prompt_git() {
  if [[ $BULLETTRAIN_GIT_SHOW == false ]]; then
    return
  fi

  local ref dirty mode repo_path git_prompt
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    if [[ $BULLETTRAIN_GIT_COLORIZE_DIRTY == true && -n $(git status --porcelain --ignore-submodules) ]]; then
      BULLETTRAIN_GIT_BG=$BULLETTRAIN_GIT_COLORIZE_DIRTY_COLOR
    fi
    prompt_segment $BULLETTRAIN_GIT_BG $BULLETTRAIN_GIT_FG

    eval git_prompt=${BULLETTRAIN_GIT_PROMPT_CMD}
    if [[ $BULLETTRAIN_GIT_EXTENDED == true ]]; then
      echo -n ${git_prompt}$(git_prompt_status)
    else
      echo -n ${git_prompt}
    fi
  fi
}
rprompt_git() {
  if [[ $BULLETTRAIN_RIGHT_GIT_SHOW == false ]]; then
    return
  fi

  local ref dirty mode repo_path git_prompt
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    if [[ $BULLETTRAIN_GIT_COLORIZE_DIRTY == true && -n $(git status --porcelain --ignore-submodules) ]]; then
      BULLETTRAIN_GIT_BG=$BULLETTRAIN_GIT_COLORIZE_DIRTY_COLOR
    fi
    #prompt_segment $BULLETTRAIN_GIT_BG $BULLETTRAIN_GIT_FG

    eval git_prompt=${BULLETTRAIN_GIT_PROMPT_CMD}
    if [[ $BULLETTRAIN_GIT_EXTENDED == true ]]; then
      rprompt_separator
      echo -n "%{%K{$BULLETTRAIN_GIT_BG}%F{$BULLETTRAIN_GIT_FG}%}"
      echo -n "${git_prompt}$(git_prompt_status) "
    else
      echo -n ${git_prompt}
    fi
  fi
}


prompt_hg() {
  if [[ $BULLETTRAIN_HG_SHOW == false ]]; then
    return
  fi

  local rev status
  if $(hg id >/dev/null 2>&1); then
    if $(hg prompt >/dev/null 2>&1); then
      if [[ $(hg prompt "{status|unknown}") = "?" ]]; then
        # if files are not added
        prompt_segment red white
        st='±'
      elif [[ -n $(hg prompt "{status|modified}") ]]; then
        # if any modification
        prompt_segment yellow black
        st='±'
      else
        # if working copy is clean
        prompt_segment green black
      fi
      echo -n $(hg prompt "☿ {rev}@{branch}") $st
    else
      st=""
      rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
      branch=$(hg id -b 2>/dev/null)
      if $(hg st | grep -Eq "^\?"); then
        prompt_segment red black
        st='±'
      elif $(hg st | grep -Eq "^(M|A)"); then
        prompt_segment yellow black
        st='±'
      else
        prompt_segment green black
      fi
      echo -n "☿ $rev@$branch" $st
    fi
  fi
}

# Dir: current working directory
__prompt_dir() {
  if [[ $BULLETTRAIN_DIR_SHOW == false ]]; then
    return
  fi

  local dir=''
  local _context="$(context)"
  [[ $BULLETTRAIN_DIR_CONTEXT_SHOW == true && -n "$_context" ]] && dir="${dir}${_context}:"

  if [[ $BULLETTRAIN_DIR_EXTENDED == 0 ]]; then
    #short directories
    dir="${dir}%1~"
  elif [[ $BULLETTRAIN_DIR_EXTENDED == 2 ]]; then
    #long directories
    dir="${dir}%0~"
  else
    #medium directories (default case)
    dir="${dir}%4(c:...:)%3c"
  fi

  prompt_segment $BULLETTRAIN_DIR_BG $BULLETTRAIN_DIR_FG $dir
}

# RUBY
# RVM: only shows RUBY info if on a gemset that is not the default one
# RBENV: shows current ruby version active in the shell
# CHRUBY: shows current ruby version active in the shell
prompt_ruby() {
  if [[ $BULLETTRAIN_RUBY_SHOW == false ]]; then
    return
  fi

  if command -v rvm-prompt > /dev/null 2>&1; then
    if [[ ! -n $(rvm gemset list | grep "=> (default)") ]]
    then
      prompt_segment $BULLETTRAIN_RUBY_BG $BULLETTRAIN_RUBY_FG $BULLETTRAIN_RUBY_PREFIX" $(rvm-prompt i v g)"
    fi
  elif command -v chruby > /dev/null 2>&1; then
    prompt_segment $BULLETTRAIN_RUBY_BG $BULLETTRAIN_RUBY_FG $BULLETTRAIN_RUBY_PREFIX"  $(chruby | sed -n -e 's/ \* //p')"
  elif command -v rbenv > /dev/null 2>&1; then
    prompt_segment $BULLETTRAIN_RUBY_BG $BULLETTRAIN_RUBY_FG $BULLETTRAIN_RUBY_PREFIX" $(rbenv version | sed -e 's/ (set.*$//')"
  fi
}

# Go
prompt_go() {
  if [[ $BULLETTRAIN_GO_SHOW == false ]]; then
    return
  fi

  setopt extended_glob
  if [[ (-f *.go(#qN) || -d Godeps || -f glide.yaml) ]]; then
    if command -v go > /dev/null 2>&1; then
      prompt_segment $BULLETTRAIN_GO_BG $BULLETTRAIN_GO_FG $BULLETTRAIN_GO_PREFIX" $(go version | grep --colour=never -oE '[[:digit:]].[[:digit:]]')"
    fi
  fi
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  if [[ $BULLETTRAIN_VIRTUALENV_SHOW == false ]]; then
    return
  fi

  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_segment $BULLETTRAIN_VIRTUALENV_BG $BULLETTRAIN_VIRTUALENV_FG $BULLETTRAIN_VIRTUALENV_PREFIX" $(basename $virtualenv_path)"
  elif which pyenv &> /dev/null; then
    prompt_segment $BULLETTRAIN_VIRTUALENV_BG $BULLETTRAIN_VIRTUALENV_FG $BULLETTRAIN_VIRTUALENV_PREFIX" $(pyenv version | sed -e 's/ (set.*$//' | tr '\n' ' ' | sed 's/.$//')"
  fi
}

# NVM: Node version manager
prompt_nvm() {
  if [[ $BULLETTRAIN_NVM_SHOW == false ]]; then
    return
  fi

  $(type nvm >/dev/null 2>&1) || return

  local nvm_prompt
  nvm_prompt=$(nvm current 2>/dev/null)
  [[ "${nvm_prompt}x" == "x" ]] && return
  nvm_prompt=${nvm_prompt}
  prompt_segment $BULLETTRAIN_NVM_BG $BULLETTRAIN_NVM_FG $BULLETTRAIN_NVM_PREFIX$nvm_prompt
}

prompt_time() {
  if [[ $BULLETTRAIN_TIME_SHOW == false ]]; then
    return
  fi

  if [[ $BULLETTRAIN_TIME_12HR == true ]]; then
    prompt_segment $BULLETTRAIN_TIME_BG $BULLETTRAIN_TIME_FG %D{%r}
  else
    prompt_segment $BULLETTRAIN_TIME_BG $BULLETTRAIN_TIME_FG %D{%T}
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
__prompt_status() {
  if [[ $BULLETTRAIN_STATUS_SHOW == false ]]; then
    return
  fi

  local symbols
  symbols=()
  [[ $RETVAL -ne 0 && $BULLETTRAIN_STATUS_EXIT_SHOW != true ]] && symbols+="✘"
  [[ $RETVAL -ne 0 && $BULLETTRAIN_STATUS_EXIT_SHOW == true ]] && symbols+="✘ $RETVAL"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡%f"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="⚙"

  if [[ -n "$symbols" && $RETVAL -ne 0 ]]; then
    prompt_segment $BULLETTRAIN_STATUS_ERROR_BG $BULLETTRAIN_STATUS_FG "$symbols"
  elif [[ -n "$symbols" ]]; then
    prompt_segment $BULLETTRAIN_STATUS_BG $BULLETTRAIN_STATUS_FG "$symbols"
  fi

}

# Prompt Character
prompt_char() {
  local bt_prompt_char
  bt_prompt_char=""

  if [[ ${#BULLETTRAIN_PROMPT_CHAR} -eq 1 ]]; then
    bt_prompt_char="${BULLETTRAIN_PROMPT_CHAR}"
  fi

  if [[ $BULLETTRAIN_PROMPT_ROOT == true ]]; then
    bt_prompt_char="%(!.%F{red}#.%F{green}${bt_prompt_char}%f)"
  fi

  if [[ $BULLETTRAIN_PROMPT_SEPARATE_LINE == false  ]]; then
    bt_prompt_char=" ${bt_prompt_char}"
  fi

  echo -n $bt_prompt_char
}

# Prompt Line Separator
prompt_line_sep() {
  if [[ $BULLETTRAIN_PROMPT_SEPARATE_LINE == true ]]; then
    # newline wont print without a non newline character, so add a zero-width space
    echo -e '\n%{\u200B%}'
  fi
}

# ------------------------------------------------------------------------------
# MAIN
# Entry point
# ------------------------------------------------------------------------------

build_prompt() {
  RETVAL=$?
  initialize_color
  prompt_time
  prompt_status
  prompt_cmd_exec_time
  prompt_custom
  prompt_context
  prompt_dir
  prompt_ruby
  prompt_virtualenv
  prompt_nvm
  prompt_go
  prompt_git
  prompt_hg
  prompt_end
  export BULLETTRAIN_BASE_COLOR
}
build_rprompt() {
  rprompt_git
  rprompt_separator
}

NEWLINE='
'
PROMPT=''
[[ $BULLETTRAIN_PROMPT_ADD_NEWLINE == true ]] && PROMPT="$PROMPT$NEWLINE"
PROMPT="$PROMPT"'%{%f%b%k%}$(build_prompt)'
[[ $BULLETTRAIN_PROMPT_SEPARATE_LINE == true ]] && PROMPT="$PROMPT$NEWLINE"
PROMPT="$PROMPT"'%{${fg_bold[default]}%}'
[[ $BULLETTRAIN_PROMPT_SEPARATE_LINE == false ]] && PROMPT="$PROMPT"
PROMPT="$PROMPT"'$(prompt_char)%{$reset_color%}'

RPROMPT="$(build_rprompt)"
