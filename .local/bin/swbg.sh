#!/bin/sh

BGLOC="${XDG_DATA_HOME:-$HOME/.local/share}/bg"
CURRENT_WALL="$(readlink -f "$BGLOC"/wall.*)"

killall -9 swaybg

WALLPAPER_DIR="${XDG_PICTURES_DIR:-$HOME/Imágenes}/walls/nord/"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)
EXT="$(basename "${WALLPAPER##*.}")"
ln -sf "$WALLPAPER" "$BGLOC"/wall."$EXT"
swaybg -i "$WALLPAPER"
