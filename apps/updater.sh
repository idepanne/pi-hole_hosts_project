#!/bin/bash
# Pi-Hole Host Project Updater
# updater.sh
# [850]
# © 2020-2022 iDépanne – L'expert informatique
# idepanne67@gmail.com

echo ""
echo ""
echo ""
echo "+=============================================================================+"
echo "|  • Mise à jour de Raspberry Pi OS                                           |"
echo "+=============================================================================+"
echo ""
echo "$ sudo apt-get full-upgrade -y"
sudo apt-get full-upgrade -y
echo ""
echo ""
echo ""
cd ~/Apps
echo "+=============================================================================+"
echo "|  • Mise à jour des logiciels                                                |"
echo "+=============================================================================+"
echo ""
echo "1. autoupdate.sh :              [INSTALLÉ]"
echo ""
echo "$ sudo mv autoupdate.sh autoupdate_old.sh"
sudo mv autoupdate.sh autoupdate_old.sh
echo ""
echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate.sh > autoupdate.sh"
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate.sh > autoupdate.sh
echo ""
echo "$ sudo chmod +x autoupdate.sh"
sudo chmod +x autoupdate.sh
echo ""
echo "1. autoupdate.sh :              [MIS À JOUR]"
echo ""
echo ""
echo ""
if [[ -d "/etc/fail2ban" ]]; then
	echo "2. Fail2ban :                   [INSTALLÉ]"
	echo ""
	echo "$ sudo rm -rv /etc/fail2ban/jail.conf"
	sudo rm -rv /etc/fail2ban/jail.conf
	echo ""
    echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/fail2ban/jail.conf > jail.conf"
    wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/fail2ban/jail.conf > jail.conf
	echo ""
	echo "$ sudo mv jail.conf /etc/fail2ban/jail.conf"
	sudo mv jail.conf /etc/fail2ban/jail.conf
	echo ""
	echo "$ sudo chown root:root /etc/fail2ban/jail.conf"
	sudo chown root:root /etc/fail2ban/jail.conf
	echo ""
	echo "$ sudo service fail2ban restart"
	sudo service fail2ban restart
	echo ""
	sleep 3
	echo "$ sudo systemctl --no-pager status fail2ban"
	sudo systemctl --no-pager status fail2ban
	echo ""
	sleep 3
	echo "$ sudo iptables -L -n"
	sudo iptables -L -n
	echo ""
	echo "$ sudo fail2ban-client status sshd"
	sudo fail2ban-client status sshd
	echo ""
	echo "2. Fail2ban :                   [MIS À JOUR]"
else
	echo "2. Fail2ban :                   [NON INSTALLÉ]"
fi
echo ""
echo ""
echo ""
if [[ -d "/etc/pihole" ]]; then
	echo "3. Pi-hole :                    [INSTALLÉ]"
	echo ""
	sudo pihole -v
	echo ""
    var50=$(sudo pihole -up)
	echo "$var50"
	if [[ "$var50" =~ "update available" ]]; then
		echo ""
	else
		echo ""
		sudo pihole -g
		echo ""
	fi
	echo "3. Pi-hole :                    [MIS À JOUR]"
else
	echo "3. Pi-hole :                    [NON INSTALLÉ]"
	echo ""
fi
echo ""
echo ""
echo "+=============================================================================+"
echo "|  • Configuration du crontab                                                 |"
echo "+=============================================================================+"
echo ""
echo "Ancien crontab :"
crontab -l
echo ""
if [[ -f "/home/pi/Apps/backup.sh" ]]; then
	crontab <<<"0 3 * * * /home/pi/Apps/autoupdate.sh > /home/pi/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
30 3 * * * /home/pi/Apps/backup.sh
0 4 * * 1-5 sudo reboot"
else
	crontab <<<"0 3 * * * /home/pi/Apps/autoupdate.sh > /home/pi/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
0 4 * * 1-5 sudo reboot"
fi
sudo /etc/init.d/cron restart
echo ""
echo "Nouveau crontab :"
crontab -l
echo ""
echo ""
echo ""
echo "+=============================================================================+"
echo "|  • Nettoyage et optimisation                                                |"
echo "+=============================================================================+"
echo ""
if [[ -d "/home/pi/Apps" ]]; then
	echo "$ cd ~/Apps"
	cd ~/Apps
	echo ""
	echo "$ sudo rm -rv *_old.sh"
	sudo rm -rv *_old.sh
	echo ""
	if [[ -d "/home/pi/Apps/log" ]]; then
		echo "$ cd ~/Apps/log"
		cd ~/Apps/log
		echo ""
		echo "$ find *.log -mtime +31 -exec rm -rv {} \;"
		find *.log -mtime +31 -exec rm -rv {} \;
	fi
fi
if [[ -d "/home/pi/.local/share/Trash/" ]]; then
	echo ""
	echo "$ sudo rm -rfv ~/.local/share/Trash/files/*"
	sudo rm -rfv ~/.local/share/Trash/files/*
	echo ""
	echo "$ sudo rm -rfv ~/.local/share/Trash/expunged/*"
	sudo rm -rfv ~/.local/share/Trash/expunged/*
	echo ""
	echo "$ sudo rm -rfv ~/.local/share/Trash/info/*"
	sudo rm -rfv ~/.local/share/Trash/info/*
fi
if [[ -d "/home/pi/.cache/thumbnails/" ]]; then
	echo "$ sudo rm -rfv ~/.cache/thumbnails/*"
	sudo rm -rfv ~/.cache/thumbnails/*
	echo ""
fi
