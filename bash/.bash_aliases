alias copy="xclip -selection clipboard"
alias gni="~/thirdparty/gnirehtet run"
alias scr="~/thirdparty/scrcpy-linux-v3.0/scrcpy"

alias batteryreport="upower -i /org/freedesktop/UPower/devices/battery_BAT0"

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias c="clear"
alias des="cd $HOME/Desktop"
alias ze="zellij"
alias dev="cd $HOME/development"
alias down="cd $HOME/Downloads"
dotfiles() {
  if [ -z "$1" ]; then
    nvim "$HOME/dotfiles"
  elif [ -d "$HOME/dotfiles/$1/.config/$1" ]; then
    nvim "$HOME/dotfiles/$1/.config/$1"
  else
    nvim "$HOME/dotfiles/$1"
  fi
}
alias shut="poweroff"
alias e="exit"
alias gc="git commit -m"
alias ga="git add"
alias gpu="git pull origin"
alias gp='git push origin'
alias media="/media/jiren/"
alias killPort="$HOME/killPort.sh"
alias sus="systemctl suspend -i"
alias ls="lsd"
alias hibernate="sudo systemctl hibernate"
alias deleteRemote="git push origin --delete"
alias deleteLocal="git branch -D"
alias gitrev="git reset --soft HEAD~1"

restartTouchpad() {
  sudo modprobe -r hid_multitouch
  sudo modprobe -r i2c_hid_acpi
  sudo modprobe i2c_hid_acpi
  sudo modprobe hid_multitouch
}
alias pms="cd $HOME/development/OSTA_PMS"
alias mereb="cd $HOME/development/Mereb/"
alias upg="sudo apt update && sudo apt upgrade -y"
