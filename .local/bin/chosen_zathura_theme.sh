#!/bin/sh

set -e

RED='\033[0;31m'
NC='\033[0m'

error_msg() {
	printf "${RED}%s${NC}\n" "$1" >&2
	exit 1
}

# Define the path to your Zathura configuration file
ZATHURA_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/zathura/"
THEME_DIR="$ZATHURA_CONF/themes/"
THEMES="$(ls "$THEME_DIR")" >/dev/null 2>&1

if [ -z "$THEMES" ]; then
	error_msg "No hay temas"
fi

MENU=$(echo "$THEMES" | rofi -dmenu -p "Temas disponibles")
THEME=$(echo "$MENU")

echo "Cambiando tema de zathura"
ln -sf "$THEME_DIR/$THEME" "$ZATHURA_CONF/zathura-theme"
