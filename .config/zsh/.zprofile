# Starting Wayland
# fix maybe yeah ok no definetly
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec mango
fi
