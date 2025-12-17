OPTIONS=" Reboot\n⏻ Shutdown"
CHOSEN=$(printf "%b" "$OPTIONS" | rofi -dmenu -i -p "Power")

case "$CHOSEN" in
  *Reboot)     sudo systemctl reboot ;;
  *Shutdown)   sudo systemctl poweroff ;;
esac

