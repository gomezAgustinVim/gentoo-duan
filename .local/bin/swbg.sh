#!/bin/sh

BGLOC="${XDG_DATA_HOME:-$HOME/.local/share}/bg"
CURRENT_WALL="$(readlink -f "$BGLOC"/wall.*)"

mkdir -p "$BGLOC"
pkill swaybg

if [ $# -eq 1 ]; then
    trueloc="$(readlink -f "$1")"
    MIME="$(file --mime-type -b "$trueloc")"
    case "$MIME" in
    image/*)
        EXT="$(basename "${1##*.}")"
        ln -sf "$trueloc" "$BGLOC"/wall."$EXT"
        ;;
    inode/directory)
        WALLPAPER="$(find "$trueloc" -iregex '.*.\(jpg\|jpeg\|png\|gif\)' -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)"
        EXT="$(basename "${WALLPAPER##*.}")"
        ln -sf "$WALLPAPER" "$BGLOC"/wall."$EXT"
        ;;
    *)
        notify-send "Mime incorrecto" "No es imagen ni directorio"
        exit 1
        ;;
    esac
    swaybg -m fill -i "$BGLOC"/wall."$EXT"
fi

WALLPAPER_DIR="${XDG_PICTURES_DIR:-$HOME/Imágenes}/walls/gentoo-walls"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)
EXT="$(basename "${WALLPAPER##*.}")"
ln -sf "$WALLPAPER" "$BGLOC"/wall."$EXT"
swaybg -m fill -i "$WALLPAPER"
