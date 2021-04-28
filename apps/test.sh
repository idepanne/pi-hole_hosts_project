#!/bin/bash
if [[ -d "/etc/pihole" ]]; then
		echo "[INSTALLÉ] Pi-hole"
		echo ""
		pihole -v
		echo ""
		var=$(sudo pihole -up)
		echo "$var"
		if [[ "$var" =~ "update available" ]]; then
			echo ""
		else
			echo ""
			# sudo pihole -g
		fi
	else
		echo "[NON INSTALLÉ] Pi-hole"
	fi
