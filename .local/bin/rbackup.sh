#!/bin/sh

set -e

# Works with runit
# Parameters for RSYNC
# Name of USB drive
DEVICES="$(lsblk -rpo "name,type,size,mountpoint" | grep /run/media/ | cut -d '/' -f7)"
MENU="$(echo "$DEVICES" | rofi -dmenu -i -p "Selecciona el dispositivo USB")"
USB="$(echo "$MENU" | cut -d ' ' -f1)"
# read -p "Nombre del dispositivo USB: " USB || exit 0
USER=$(whoami)
COPIADOS="$@"
BACKUP_FILTER="$HOME/Documentos/backup.filter"

# File to store backup history
FECHA_HORA=$(date +%d%m%y-%H-%M-%S)
# USB PATH GOES HERE
BACKUPS="/run/media/$USER/$USB/backup"
DESTINO="$BACKUPS/$FECHA_HORA"

if [ -z "$COPIADOS" ]; then
    echo "Uso: $(basename $0) /path/to/source1 /path/to/source2"
    exit 1
fi

# Count directories in BACKUPS
DIR_COUNT=$(find "$BACKUPS" -maxdepth 1 -type d ! -path "$BACKUPS" | wc -l)

if [ $DIR_COUNT -gt 1 ]; then
    echo "Hay más de un directorio en $BACKUPS." "Sólo puede haber uno"
    exit 1
fi

# Get backup dir
ORIGEN=$(ls -1 "$BACKUPS" 2>/dev/null)

if [ -z "$ORIGEN" ]; then
    notify-send "Primer Backup" "Creando estructura inicial..."
    mkdir -p "$DESTINO"
    notify-send "Directorio creado con éxito nwn"
else
    # Rename the old backup to the current timestamp
    mv "$BACKUPS/$ORIGEN" "$DESTINO"
fi

rsync -a --delete --filter="merge $BACKUP_FILTER" $COPIADOS $DESTINO

if [ $? -eq 0 ]; then
    notify-send "Backup completado" "Los archivos se han copiado a $DESTINO"
else
    notify-send "Error en el backup" "Hubo un problema al copiar los archivos a $DESTINO"
fi
