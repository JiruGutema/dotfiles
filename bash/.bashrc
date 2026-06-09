# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it 
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support for LS definitions via dircolors
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  # Aliases moved to ~/.bash_aliases (keeps ~/.bashrc small)
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# You can put interactive-only aliases and functions in ~/.bash_aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

shopt -s nocaseglob

# rbenv init (moved to profile if you prefer system-wide; keep here or in ~/.profile)
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init - zsh)"
fi

docker-rm-search() {
  if [ -z "$1" ]; then
    echo "Usage: docker-rm-search <keyword>"
    return 1
  fi

  docker images --format "{{.ID}} {{.Repository}}:{{.Tag}}" |
    grep -i "$1" |
    awk '{print $1}' |
    xargs -r docker rmi -f
}

# interactive-only helper and shell extensions
# ble.sh and other interactive hooks (keep in ~/.bashrc)
source ~/.local/share/blesh/ble.sh

# If you want per-project envs, use direnv:
# eval "$(direnv hook bash)"

# ========================START OF IMPORTS ============================
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# LM Studio CLI
export PATH="$PATH:$HOME/.lmstudio/bin"

# Go and user-local bins
export PATH=$PATH:/usr/local/go/bin
# Created by `pipx`
export PATH="$PATH:$HOME/.local/bin"

# dotnet and go
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$HOME/.dotnet:$PATH
export PATH=$PATH:$HOME/go/bin

# history timestamp format (persisted)
export HISTTIMEFORMAT="%F %T "

# Flutter
export PATH="$PATH:$HOME/flutter/flutter/bin"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# opencode and user dir
export PATH=$HOME/.opencode/bin:$PATH
export PATH="$PATH:$HOME"
export PATH="$PATH:/usr/share/code/bin"

# Apache ant
export ANT_HOME=/opt/apache-ant-1.9.1
export PATH=$ANT_HOME/bin:$PATH

# tools added by scripts
export PATH="$HOME/.aspire/bin:$PATH"
export PATH=$PATH:$HOME/.spicetify

# X cursor settings for X sessions
export XCURSOR_THEME="Yaru"
export XCURSOR_SIZE=24

# Startship git information
eval "$(starship init bash)"


# ========================END OF IMPORTS ============================
# add clear at the end of loading
clear
# end of ~/.bashrc
export PATH="$PATH:/opt/mssql-tools18/bin"
