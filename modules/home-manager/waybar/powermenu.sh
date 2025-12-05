#!/usr/bin/env zsh
# shellcheck disable=SC1071

# Options for the power menu
options="Shutdown\nReboot\nSuspend\nLogout"

# Show menu via rofi (Wayland-compatible)
choice=$(echo -e "$options" | rofi -dmenu -i -p "Power")

case "$choice" in
    Shutdown) systemctl poweroff ;;
    Reboot)   systemctl reboot ;;
    Suspend)  systemctl suspend ;;
    Logout)   hyprctl dispatch exit ;;
esac
