#!/bin/bash
dconf dump /org/gnome/shell/extensions/o-tiling/ > "$(dirname "$0")/o-tiling.conf"
echo "o-tiling config updated"

# ~/dotfiles/o-tiling/update-o-tiling-config.sh
