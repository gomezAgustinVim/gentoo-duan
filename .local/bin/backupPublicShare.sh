#!/bin/sh

# Parameters for RSYNC
COPIADOS="$@"

# My filter rules
BACKUP_FILTER="$HOME/Documentos/backupPublic.filter"

# File to store backup history
DAY=$(date +%A)
FECHA_HORA=$(date +%d%m%y-%H-%M-%S)
# USB PATH GOES HERE
BACKUPS="$HOME/Publico/backup"
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

# Use -z only if you want to compress the data over network
# as this uses SMB, you may wanna use it if your network is slow
# rsync -a --quiet --inplace --delete --backup --backup-dir="$HOME/Publico/backup/incr/$DAY" --suffix=.bak --filter="merge $BACKUP_FILTER" $COPIADOS $DESTINO
# The --inplace option implies --partial and updates destination files in-place.

rsync -a --delete --filter="merge $BACKUP_FILTER" $COPIADOS $DESTINO

if [ $? -eq 0 ]; then
    notify-send "Backup completado" "Los archivos se han copiado a $DESTINO"
else
    notify-send "Error en el backup" "Hubo un problema al copiar los archivos a $DESTINO"
fi
