#!/bin/bash
clip="$HOME/go/bin/cliphist"
[ -x "$clip" ] || clip="$(command -v cliphist)"
[ -x "$clip" ] || { notify-send "cliphist not found"; exit 1; }

sel="$($clip list | wofi --dmenu -p Clipboard)"
[ -z "$sel" ] && exit 0
echo "$sel" | $clip decode | wl-copy
