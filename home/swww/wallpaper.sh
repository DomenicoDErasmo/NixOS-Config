#!/run/current-system/sw/bin/bash

wallpapersDir="/home/domenico/Pictures/wallpapers/nature"
image=$(find "$wallpapersDir" | shuf -n 1)
swww img "$image"
