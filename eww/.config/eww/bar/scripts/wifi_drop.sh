#!/bin/sh
# kitty @ --to=unix:/run/user/1000/kitty.socket send-text --match=title:list "rofi -show wifi -modi wifi:iwdrofimenu\n"
kitty --title "WifiConfig" --hold -e sh -c 'rofi -show wifi -modi wifi:iwdrofimenu'

