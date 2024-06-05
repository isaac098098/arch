[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx --vt1

#if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
	#exec Hyprland
#fi
