#!/bin/sh

RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0)

# Necesita rofi para andar

set -e # abort on error

# Get current user
USUARIO=$(whoami)

# mounted for one user
LIST=$(ls "/run/media/$USUARIO") >/dev/null 2>&1 || exit 0

# Si no hay dispositivos
if [ -z "$LIST" ]; then
	printf "%sERROR:%s No hay dispositivos montados para %s%s%s\n" "$RED" "$NC" "$BLUE" "$USUARIO" "$NC"
else
	# rofi menu for list
	MENU=$(echo "$LIST" | rofi -dmenu -p 'Dispositivo USB')

	DEVICE_NAME="$MENU"
	MOUNT_POINT="/run/media/$USUARIO/$DEVICE_NAME"

	while true; do
		printf "¿Desmontar dispositivo USB seleccionado: s/n? \n"
		read -r resp
		case "$resp" in
		[sS])
			printf "Desmontando %s%s...%s\n" "$BLUE" "$MOUNT_POINT" "$NC"
			# sudo -A umount -l "$MOUNT_POINT"
            doas umount -l "$MOUNT_POINT"
			printf "%sEXITO:%s Dispositivo USB desmontado con éxito\n" "$GREEN" "$NC"
			break
			;;
		[nN])
			printf "Continuando%s sin desmontar%s dispositivo USB\n" "$BLUE" "$NC"
			break
			;;
		*)
			printf "%sRespuesta invalida%s ingrese 's' o 'n' NWN%s\n" "$RED" "$BLUE" "$NC"
			;;
		esac
	done
fi

# publico montado?
PUBLIC_MOUNT="$(find "$HOME"/Público -maxdepth 1 ! -name "Público" | wc -l)"
if [ "$PUBLIC_MOUNT" -gt 0 ]; then
	# unmount public
	while true; do
		printf "Desmontar carpeta público tambien? s/n: "
		read -r resp
		case "$resp" in
		[sS])
			printf "Desmontando %s$HOME/Público...%s\n" "$BLUE" "$NC"
			# sudo -A umount -l "$HOME/Público"
            doas umount -l "$HOME/Público"
			printf "Público%s desmontado%s\n" "$GREEN" "$NC"
			break
			;;
		[nN])
			printf "Continuando%s sin desmontar%s Publico\n" "$BLUE" "$NC"
			break
			;;
		*)
			printf "%sRespuesta invalida%s ingrese 's' o 'n' NWN%s\n" "$RED" "$BLUE" "$NC"
			;;
		esac
	done
else
	printf "%sADVERTENCIA:%s No hay carpeta publico montada\n" "$YELLOW" "$NC" >&2
fi
