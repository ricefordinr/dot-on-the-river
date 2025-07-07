#!/bin/sh

infoDir=~/.config/river/scripts/screenScalingInfo.txt
scale="$(cat "$infoDir")"
echo $scale

case $scale in 
    1)
        echo 0.77 > "$infoDir"
        ;;
    0.77)
        echo 1 > "$infoDir"
        ;;
    *)
        exit
        ;;
esac

wlr-randr --output HDMI-A-1 --scale $scale
