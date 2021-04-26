#!/bin/bash
var=$(pihole -v)
if [[ "$var" =~ "Pi-hole version is" ]]; then
	echo "$var"
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
	echo ""
fi
