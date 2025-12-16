OPTIONS=" Lock\n Reboot\n⏻ Shutdown"
CHOSEN=$(printf "$OPTIONS" | rofi -dmenu -i -p "Power")

case "$CHOSEN" in
  *Lock)       sudo loginctl lock-session ;;
  *Reboot)     sudo systemctl reboot ;;
  *Shutdown)   sudo systemctl poweroff ;;
esac

