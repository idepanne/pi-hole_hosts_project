#!/bin/bash
echo "$ pihole"
	var=$(pihole)
		echo "$var"
		if [[ "$var" =~ "introuvable" ]]; then
			echo ""
		else
			echo ""
			echo "$ sudo pihole -g"
			# sudo pihole -g
		fi
