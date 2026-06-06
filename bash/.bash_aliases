alias cat="batcat"

alias copy="xclip -selection clipboard"
alias gni="~/mobileTool/gnirehtet run"
alias scr="~/mobileTool/scrcpy-linux-v3.0/scrcpy"

alias start-emulator="emulator -avd Pixel_6a -gpu host & disown"
alias stop-emulator="adb emu kill || pkill -f emulator"

parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\e[1;32m\]\u@\h \[\e[38;5;117m\]\w\[\e[0m\]\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

echo -e '\e[5 q'
alias batteryreport="upower -i /org/freedesktop/UPower/devices/battery_BAT0"

alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias c="clear"
alias des="cd /home/jiren/Desktop"
alias ze="zellij"
alias dev="cd /home/jiren/development"
alias down="cd /home/jiren/Downloads"
alias shut="poweroff"
alias e="exit"
alias gc="git commit -m"
alias ga="git add"
alias gpu="git pull origin"
alias gp='git push origin'
alias media="/media/jiren/"
alias killPort="/home/jiren/killPort.sh"
alias sus="systemctl suspend -i"
alias ls="lsd"
alias hibernate="sudo systemctl hibernate"
alias reload="source ~/.bashrc"
alias ibeam="echo -e '\e[5 q'"
alias python="python3"
alias py="python3"
alias share="killPort 1234 && cd /home/jiren/development/FileSharing\ Hub && node index.js"
alias deleteRemote="git push origin --delete"
alias deleteLocal="git branch -D"
alias gitrev="git reset --soft HEAD~1"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias createHotSpot="wihotspot"
alias musia="nohup /home/jiren/musializer/build/musializer > /dev/null 2>&1 &"
alias startService="sudo systemctl start"
alias stopService="sudo systemctl start"
alias flushNeighbor="sudo ip neigh flush all"
restartTouchpad() {
  sudo modprobe -r hid_multitouch
  sudo modprobe -r i2c_hid_acpi
  sudo modprobe i2c_hid_acpi
  sudo modprobe hid_multitouch

}

alias ant-openelis='JAVA_HOME=/opt/jdk1.7.0_80 PATH=/opt/jdk1.7.0_80/bin:$PATH ant'
alias pms='cd /home/jiren/development/OSTA_PMS'
