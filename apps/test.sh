#!/bin/bash
	echo "==============================================================================="
	echo "                   Mises à jour des logiciels complémentaires                  "
	echo "==============================================================================="
	echo ""
	echo "• Pi-Hole :"
	echo ""
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
		echo "Le logiciel \"Pi-Hole\" n'est pas installé"
	fi
