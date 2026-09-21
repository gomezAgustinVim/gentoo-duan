#!/bin/sh

echo "Desea convertir todos los directorios y subdirectorios a mp3?"
printf "'s' para sí, 'n' para no: "
read -r rta
case "$rta" in
[Ss])
	find . -type f \( -name '*.flac' -o -name '*.aiff' \) -print \
		-exec sh -c \
		'i="$1"; ffmpeg -loglevel warning -i "$i" -y -b:a 320k "${i%.*}.mp3" && rm -f "$i"' \
		_ {} \;
	notify-send "Conversion de flac a mp3 completada nwn"
	;;
[Nn]) exit 0 ;;
*)
	echo "Opción invalida" >&2
	exit 1
	;;
esac
