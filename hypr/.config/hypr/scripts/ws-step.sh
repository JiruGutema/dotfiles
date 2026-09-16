#!/bin/bash
dir="$1"
cur=$(hyprctl activeworkspace -j | jq '.id')
max_used=$(hyprctl workspaces -j | jq '[.[] | select(.id > 0 and .windows > 0) | .id] | max // 1')
max_allowed=$((max_used + 1))
target=$((cur + dir))

[ "$target" -lt 1 ] && exit 0
[ "$target" -gt "$max_allowed" ] && exit 0

hyprctl dispatch "hl.dsp.focus({ workspace = \"$target\" })"
