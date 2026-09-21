#!/bin/sh

# 300 segundos = 5 minutos

DPMS_OFF="hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'"
DPMS_ON="hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'"

swayidle -w \
	before-sleep "pidof swaylock || swaylock -f" \
	after-resume "$DPMS_ON" \
	timeout 150 "brillo -O && brillo -S 5.0" \
	resume "brillo -I" \
	timeout 300 "pidof swaylock || swaylock -f" \
	timeout 330 "$DPMS_OFF" \
	resume "$DPMS_ON"
