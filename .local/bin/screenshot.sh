#!/bin/sh

# This is bound to Shift+PrintScreen by default, requires maim. It lets you
# choose the kind of screenshot to take, including copying the image or even
# highlighting an area to copy. scrotcucks on suicidewatch right now.
# it also checks whether you're on a wayland session or not
# in which case it uses maim

if [ "$XDG_SESSION_TYPE" != "wayland" ]; then
	# variables
	output="$(date '+%y%m%d-%H%M-%S').png"
	xclip_cmd="xclip -sel clip -t image/png"

	case "$(printf "area seleccionada\\nventana actual\\npantalla completa\\narea seleccionada (copiar)\\nventana actual (copiar)\\npantalla completa (copiar)" | rofi -dmenu -l 6 -i -p "Tipo de selección")" in
	"area seleccionada") maim -s -u -o pic-selected-"${output}" ;;
	"ventana actual") maim -u -q -d 0.2 -o -i "$(xdotool getactivewindow)" pic-window-"${output}" ;;
	"pantalla completa") maim -u -q -d 0.2 -o pic-full-"${output}" ;;
	"area seleccionada (copiar)") maim -s -u -o | ${xclip_cmd} ;;
	"ventana actual (copiar)") maim -u -q -d 0.2 -o -i "$(xdotool getactivewindow)" | ${xclip_cmd} ;;
	"pantalla completa (copiar)") maim -u -q -d 0.2 -o | ${xclip_cmd} ;;
	esac
fi

# El siguiente script requiere rofi, hyprland, jq, grim y slurp
# Toma una captura del escritorio siguiendo varias opciones

# monitor = hyprctl monitors | grep "ID 0" | cut -d ' ' -f2
output="$(date '+%y%d%m-%H%M-%S').png"

case "$(printf "area seleccionada\\nventana actual\\npantalla completa\\ncopiar area seleccionada\\ncopiar ventana actual\\ncopiar pantalla completa" | rofi -dmenu -l 6 -i -p "Tipo de selección")" in
"area seleccionada") grim -g "$(slurp -w 0)" "$(xdg-user-dir PICTURES)"/pic-sel-"${output}" ;;
"ventana actual") sleep 0.3 && mmsg get focusing-client | jq -r '"\(.x),\(.y) \(.width)x\(.height)"' | grim -g - "$(xdg-user-dir PICTURES)"/pic-win-"${output}" ;;
"pantalla completa") sleep 0.3 && grim "$(xdg-user-dir PICTURES)"/pic-full-"${output}" ;;
"copiar area seleccionada") grim -g "$(slurp -w 0)" - | wl-copy ;;
"copiar ventana actual") sleep 0.3 && mmsg get focusing-client | jq -r '"\(.x),\(.y) \(.width)x\(.height)"' | grim -g - - | wl-copy ;;
"copiar pantalla completa") sleep 0.3 && grim - | wl-copy ;;
esac
