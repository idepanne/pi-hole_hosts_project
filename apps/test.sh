#!/bin/bash
if [[ -d "/etc/pihole" ]]; then
	pihole -v
	echo ""
	echo "$ sudo pihole -up"
	var=$(sudo pihole -up)
		echo "$var"
		if [[ "$var" =~ "update available" ]]; then
			echo ""
		else
			echo ""
			echo "$ sudo pihole -g"
			sudo pihole -g
		fi
else
	echo "Pi-Hole n'existe pas"
fi
