#source ~/.vim/gruvbox_256palette.sh
#source /usr/share/bash-completion/bash_completion

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
  fi
}

PS1="\[$COLOR_GREEN\][\h@\w]\[$COLOR_RESET\]"
PS1+="\[\$(git_color)\]"        # colors git status
PS1+="\$(git_branch)"           # prints current branch
PS1+="\[$COLOR_GREEN\]\$\[$COLOR_RESET\] "   # '#' for root, else '$'
export PS1

# command line calculator
calc(){ awk "BEGIN{ print $* }" ;}
[[ "$-" != *i* ]] && return

# ignore small typos
shopt -s cdspell

# turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export PYTHONDONTWRITEBYTECODE=YES


# Default to human readable figures
alias df='df -h'
alias du='du -h'

alias transru='trans -t ru -brief'
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

alias ls='ls --color=auto'                 # classify files in colour
alias ll='ls -l --color=auto'                              # long list
alias la='ls -la --color=auto'                              # long list
alias ..='cd ..'
alias l='ls -lF'
alias tmux='TERM=screen-256color tmux -2'
alias telegram='proxychains telegram -N'
alias gw='gtkwave'
# alias openvpn='sudo openvpn /etc/openvpn/miet.conf'
# alias tmux='TERM=screen-256color-bce tmux -2'

# if [[ "$TERM" != "screen-256color" ]]; then
#   tmux
# fi

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx
fi

adoc() {
  filename=$(basename "$1")
  extension="${filename##*.}"
  filename="${filename%.*}"
  asciidoc $1
  firefox $filename.html
}

2hex() {
  echo "obase=16; $1" | bc
}

2dec() {
  echo "ibase=16; $1" | bc
}
