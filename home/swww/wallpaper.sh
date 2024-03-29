#!/run/current-system/sw/bin/bash

homeDirectory="/home/domenico"
wallpapersDir="$homeDirectory/Pictures/wallpapers/nature"
image=$(find "$wallpapersDir" | shuf -n 1)
swww img "$image"
wal -c
wal -i "$image"
wal -c

# For use by other processes
# TODO: can I make this a global const?
rm -fr "$homeDirectory"/wallpaper
cp -fr "$image" "$homeDirectory"/wallpaper
