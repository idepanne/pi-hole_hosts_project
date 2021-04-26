#!/bin/bash
	echo "==============================================================================="
	echo "                   Mises à jour des logiciels supplémentaires                  "
	echo "==============================================================================="
	echo ""
	if [[ -d "/etc/pihole" ]]; then
		echo "• Pi-Hole :          [Installé]"
		echo ""
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
			# sudo pihole -g
		fi
	else
		echo "• Pi-Hole :          [Non installé]"
	fi
	echo ""
	echo ""
	echo ""
