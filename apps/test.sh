#!/bin/bash
	var=$(pihole -v)
		echo "$var"
		if [[ "$var" =~ "commande introuvable" ]]; then
			echo ""
		else
			echo ""
			echo "$ sudo pihole -g"
			# sudo pihole -g
		fi
