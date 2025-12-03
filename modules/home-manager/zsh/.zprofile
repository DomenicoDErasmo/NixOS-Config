# Only launch Hyprland on TTY1
    if [[ $(tty) == /dev/tty1 ]]; then
        exec Hyprland
    fi