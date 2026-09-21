#!/bin/sh

if [ "$XDG_SESSION_TYPE" != "wayland" ]; then
	echo "" | xclip -sel clip
	gpg -d "$1" | xclip -r -sel clip
	sleep 5
	echo "" | xclip -sel clip
fi

PASS_LOC="$HOME/Documentos/keepass.gpg"

echo "" | wl-copy
gpg -d "$PASS_LOC" | wl-copy --trim-newline
sleep 5
echo "" | wl-copy
