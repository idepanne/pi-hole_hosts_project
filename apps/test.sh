#!/bin/bash
var=$(pihole -v)
if [[ "$var" =~ "Pi-hole version is" ]]; then
	echo "$var"
	echo ""
	echo "$ sudo pihole -g"
	# sudo pihole -g
else
	echo ""
	echo "RIEN !!!"
fi
