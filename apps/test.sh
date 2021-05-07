#!/bin/bash
if [[ -d "/etc/fail2ban" ]]; then
	echo "-> Fail2ban :           [INSTALLÉ]"
	echo ""
	echo "$ sudo rm -rv /etc/fail2ban/jail.local"
	sudo rm -rv /etc/fail2ban/jail.local
	echo ""
	var=$(find /home/pi/config.txt -exec grep -H 'beta=' {} \;)
	if [[ "$var" =~ "beta=1" ]]; then
		echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/beta/jail.local > jail.local"
		wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/beta/jail.local > jail.local
	else
		echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/release/jail.local > jail.local"
		wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/release/jail.local > jail.local
	fi
	echo ""
	echo "$ sudo mv jail.local /etc/fail2ban/jail.local"
	sudo mv jail.local /etc/fail2ban/jail.local
	echo ""
	echo "$ sudo service fail2ban restart"
	sudo service fail2ban restart
	echo ""
	echo "$ sudo systemctl --no-pager status fail2ban"
	sudo systemctl --no-pager status fail2ban
else
	echo "-> Fail2ban :           [NON INSTALLÉ]"
fi
