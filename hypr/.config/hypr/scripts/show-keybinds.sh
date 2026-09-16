#!/bin/bash

# Toggle: close if already open
if pgrep -f 'wofi.*Keybinds' >/dev/null; then
    pkill -f 'wofi.*Keybinds'
    exit 0
fi

hyprctl binds -j | jq -r '
  .[]
  | select(.dispatcher != "submap")
  | "\(.modmask)\t\(.key)\t\(.description // .dispatcher)\t\(.arg // "")"
' | while IFS=$'\t' read -r mod key desc arg; do
  mods=""
  # modmask bits: 1=SHIFT 4=CTRL 8=ALT 64=SUPER (common Hyprland values)
  (( mod & 64 )) && mods+="SUPER+"
  (( mod & 4 ))  && mods+="CTRL+"
  (( mod & 8 ))  && mods+="ALT+"
  (( mod & 1 ))  && mods+="SHIFT+"
  printf "%-22s  %s\n" "${mods}${key}" "${desc}${arg:+ ($arg)}"
done | sort -u | wofi --dmenu -i -p "Keybinds" -W 640 -H 480 >/dev/null
