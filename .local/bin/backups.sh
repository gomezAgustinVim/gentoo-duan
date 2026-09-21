#!/bin/sh
USUARIO=$(whoami)
DISPOSITIVO="Seagate-Backup"
DEST=/run/media/"$USUARIO"/"$DISPOSITIVO"/backup/
BACKUP_FILTER="${XDG_DATA_HOME:-$HOME/.local/share}/backup.filter"

# Size of file is = 0 bytes
if [ ! -s "$BACKUP_FILTER" ]; then
	cat <<EOF >"$BACKUP_FILTER"
# Exclude patterns
- *.tmp
- *.log
- *.git
- .thumbnails/
- .cache/
- .Rhistory
- .RData
- .vagrant/
- .vscode/
- target/
- data/
- *.part
- bin/
- obj/
- .DS_Store
- node_modules/
- Images/
EOF
fi

trap 'notify-send "\nBackup cancelado por el usuario. nwn" ; exit 130' INT

echo "Procediendo al backup nwn..."

# backup completo del sistema preservando atributos extendidos y ACLs
echo "Sincronizando archivos desde $HOME... nwn"
cd "$HOME" || return

mkdir -p "$DEST"

if [ ! -d "${DEST%/backup/}" ]; then
	notify-send "Error en Backup nwn" "El disco $DISPOSITIVO no está conectado o montado."
	exit 1
fi

if rsync -aAXHv --delete --filter="merge $BACKUP_FILTER" \
	--exclude=docker-volumes --exclude=ISO \
	Descargas Documentos Imágenes Música Vídeos Escritorio Proyectos \
	~/.local/share/Obsidian "$DEST"; then

	HOY=$(date +%c)
	notify-send "Backup completo nwn" "$HOY"
else
	notify-send "Error en Backup nwn" "Hubo un problema durante la sincronización. rsync finalizó con errores el $(date +%b_%d_%H:%M)"
fi
