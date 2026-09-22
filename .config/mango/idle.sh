exec swayidle -w \
    timeout 300 'brightnessctl -s set 10' \
        resume 'brightnessctl -r' \
    timeout 600 'wlr-randr --output eDP-1 --off && swaylock -f' \
        resume 'wlr-randr --output eDP-1 --on' \
    before-sleep 'swaylock -f'
