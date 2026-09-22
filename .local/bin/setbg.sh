#!/bin/sh

# x only
# Location of link to wallpaper link.
bgloc="${XDG_DATA_HOME:-$HOME/.local/share}/bg"

trueloc="$(readlink -f "$1")" &&
	case "$(file --mime-type -b "$trueloc")" in
	image/*) ln -sf "$trueloc" "$bgloc" && notify-send -i "$bgloc" "Changing wallpaper..." ;;
	inode/directory) ln -sf "$(find "$trueloc" -iregex '.*.\(jpg\|jpeg\|png\|gif\)' -type f | shuf -n 1)" "$bgloc" && notify-send -i "$bgloc" "Random Wallpaper chosen." ;;
	*)
		notify-send "❌ Error" "No es directorio ni tipo de imagen validos"
		exit 1
		;;
	esac

xwallpaper --stretch "$bgloc"
