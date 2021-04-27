#!/bin/bash
	echo "==============================================================================="
	echo "                   Mises à jour des logiciels supplémentaires                  "
	echo "==============================================================================="
	echo ""
	if [[ -f "/home/pi/autoupdate.sh" ]]; then
		echo "[   Installé   ]   autoupdate.sh"
		echo ""
		echo "$ sudo mv autoupdate.sh autoupdate_old.sh"
		sudo mv autoupdate.sh autoupdate_old.sh
		echo ""
		echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate.sh > autoupdate.sh"
		wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate.sh > autoupdate.sh
		echo ""
		echo "$ sudo chmod +x autoupdate.sh"
		sudo chmod +x autoupdate.sh
	else
		echo "[ Non installé ]   autoupdate.sh"
	fi
	echo ""
	echo ""
	echo ""
	if [[ -d "/etc/fail2ban" ]]; then
		echo "[   Installé   ]   Fail2ban"
		echo ""
		echo "$ sudo rm -rv /etc/fail2ban/jail.local"
		sudo rm -rv /etc/fail2ban/jail.local
		echo ""
		echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/jail.local > jail.local"
		wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/jail.local > jail.local
		echo ""
		echo "$ sudo mv jail.local /etc/fail2ban/jail.local"
		sudo mv jail.local /etc/fail2ban/jail.local
		echo ""
		echo "$ sudo service fail2ban restart"
		sudo service fail2ban restart
		echo ""
		echo "sudo systemctl --no-pager status fail2ban"
		sudo systemctl --no-pager status fail2ban
	else
		echo "[ Non installé ]   Fail2ban"
	fi
	echo ""
	echo ""
	echo ""
	if [[ -d "/etc/pihole" ]]; then
		echo "[   Installé   ]   Pi-hole"
		echo ""
		pihole -v
		echo ""
		var=$(sudo pihole -up)
		echo "$var"
		if [[ "$var" =~ "update available" ]]; then
			echo ""
		else
			echo ""
			sudo pihole -g
		fi
	else
		echo "[ Non installé ]   Pi-hole"
	fi
	echo ""
	echo ""
	echo ""
