#!/bin/sh

terminal="${TERMINAL:-footclient}"

set -eu

TMUX_BIN="$(command -v tmux || {
	echo 'tmux not found'
	exit 1
})"
ROFI_BIN="$(command -v rofi || {
	echo 'rofi not found'
	exit 1
})"
ROFI_OPTS='-dmenu -i -p "Sesiones: " -l 10 -no-custom'

sessions="$("$TMUX_BIN" list-sessions -F '#S' 2>/dev/null || true)"
[ -n "${sessions}" ] || exit 0

# Add a "create new" entry at the top
menu="Crear nueva sesión...\n$sessions"

selection="$(printf '%b' "$menu" | eval "$ROFI_BIN $ROFI_OPTS" || true)"
[ -n "$selection" ] || exit 0

if [ "$selection" = "Crear nueva sesión..." ]; then
	new_name="$(printf '' | eval "$ROFI_BIN -dmenu -i -p 'Nuevo nombre de sesión: '" || true)"
	[ -n "$new_name" ] || exit 0
	session="$new_name"
	create=1
else
	session="$selection"
	create=0
fi

# Inside tmux: create (detached) if needed, then switch (NO exec on create)
if [ -n "${TMUX-}" ]; then
	if [ "$create" -eq 1 ] && ! "$TMUX_BIN" has-session -t "$session" 2>/dev/null; then
		"$TMUX_BIN" new-session -ds "$session"
	fi
	exec "$TMUX_BIN" switch-client -t "$session"
fi

if [ "$create" -eq 1 ]; then
	# create and attach
	exec $terminal "$TMUX_BIN" new-session -s "$session"
else
	# attach existing
	exec $terminal "$TMUX_BIN" attach -t "$session"
fi
