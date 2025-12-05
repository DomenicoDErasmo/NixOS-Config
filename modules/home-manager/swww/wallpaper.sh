#!/run/current-system/sw/bin/zsh
# shellcheck disable=SC1071

homeDirectory="/home/domenico"
wallpapersDir="$homeDirectory/Pictures/wallpapers/nature"
image=$(find "$wallpapersDir" | shuf -n 1)
swww img "$image" --transition-duration 1 --transition-type fade
wallust run "$image" -p dark16

# For use by other processes
# TODO: can I make this a global const?
rm -fr "$homeDirectory"/wallpaper
cp -fr "$image" "$homeDirectory"/wallpaper