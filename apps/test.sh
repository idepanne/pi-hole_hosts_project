#!/bin/bash
	var=$(pihole -v)
		echo "$var"
		if [[ "$var" =~ "Pi-hole version is" ]]; then
			echo "$ sudo pihole -g"
			# sudo pihole -g
		else
			echo "RIEN !!!"
		fi
