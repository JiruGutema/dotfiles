alias cat="batcat"

alias copy="xclip -selection clipboard"
alias gni="~/mobileTool/gnirehtet run"
alias scr="~/mobileTool/scrcpy-linux-v3.0/scrcpy"

alias start-emulator="emulator -avd Pixel_6a -gpu host & disown"
alias stop-emulator="adb emu kill || pkill -f emulator"


echo -e '\e[5 q'
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
alias reload="source ~/.bashrc"
alias ibeam="echo -e '\e[5 q'"
alias python="python3"
alias py="python3"
alias share="killPort 1234 && cd \"$HOME/development/FileSharing Hub\" && node index.js"
alias deleteRemote="git push origin --delete"
alias deleteLocal="git branch -D"
alias gitrev="git reset --soft HEAD~1"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias createHotSpot="wihotspot"
alias musia="nohup $HOME/musializer/build/musializer > /dev/null 2>&1 &"
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
alias pms="cd $HOME/development/OSTA_PMS"
