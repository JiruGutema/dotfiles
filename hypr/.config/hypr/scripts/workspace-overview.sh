#!/bin/bash

# If overview wofi is already open, close it and exit
if pgrep -f "wofi --dmenu -p Windows" >/dev/null 2>&1 || \
   pgrep -f "wofi --dmenu --prompt Workspaces" >/dev/null 2>&1; then
  pkill -f "wofi --dmenu"
  exit 0
fi

choice=$(
  hyprctl clients -j | jq -r '
    .[]
    | select(.mapped == true and .workspace.id >= 1)
    | "\(.workspace.id)  \(.class)  \(.title[0:50])  \(.address)"
  ' | sort -n | wofi --dmenu -p "Windows" -W 700 -H 400
)

[ -z "${choice:-}" ] && exit 0
addr=$(echo "$choice" | awk '{print $NF}')
hyprctl dispatch focuswindow "address:$addr"
