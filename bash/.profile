# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# ~/.profile - environment variables and PATH tweaks moved out of ~/.bashrc

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

# End of ~/.profile
