#!/bin/sh

# Archivo con rutas
routes="$HOME/Documentos/rutas.txt"

terminal="${TERMINAL:-footclient}"

rofi_parse_output() {
	if command -v rofi >/dev/null 2>&1; then
		rofi -dmenu -i -p 'Directorios: ' -l 10 -matching fuzzy -no-custom
	fi
}

if [ $# -eq 1 ]; then
	selected=$1
	from_terminal=1
else
	selected=$(
		xargs -I{} find {} -mindepth 1 -maxdepth 1 \( ! -name '.*' -o -name '.config' -o -name '.local' \) -type d <"$routes" |
			sed "s|^$HOME/||" |
			rofi_parse_output
	)
	[ -n "$selected" ] && selected="$HOME/$selected" # Add home path back
	from_terminal=0
fi

[ -n "$selected" ] || exit 0

selected_name=$(basename "$selected" | tr . _)

if [ "$selected" = "." ]; then
	selected_name="$(basename "$PWD")"
	selected="$PWD"
fi

if [ -n "${TMUX-}" ]; then
	# Crear si no existe, luego hacer switch (sin abrir $terminal — ya estamos en tmux)
	if ! tmux has-session -t "$selected_name" 2>/dev/null; then
		tmux new-session -ds "$selected_name" -c "$selected"
	fi
	exec tmux switch-client -t "$selected_name"
fi

# Fuera de tmux: crear si no existe, luego adjuntar en $terminal
if ! tmux has-session -t "$selected_name" 2>/dev/null; then
	tmux new-session -ds "$selected_name" -c "$selected"
fi

if [ "$from_terminal" -eq 1 ]; then
	exec tmux attach-session -t "$selected_name" # reusar la terminal actual
else
	exec $terminal tmux attach-session -t "$selected_name" # abrir $terminal
fi
