#!/bin/bash
echo "$ cd /etc/pihole/"
	var=$(cd /etc/pihole/)
		echo "$var"
		if [[ "$var" =~ "Aucun" ]]; then
			echo ""
		else
			echo ""
			echo "$ sudo pihole -g"
			# sudo pihole -g
		fi
