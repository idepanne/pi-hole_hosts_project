#!/bin/bash
# Pi-Hole Host Project Updater 8.2.2b8
# updater.sh
# © 2020-2022 iDépanne – L'expert informatique
# https://fb.me/idepanne/
# idepanne67@gmail.com

echo ""
echo ""
echo ""
echo "==============================================================================="
echo "   • Mise à jour de Raspberry Pi OS"
echo "==============================================================================="
echo ""
echo "$ sudo apt-get full-upgrade -y"
sudo apt-get full-upgrade -y
echo ""
echo "$ sudo apt-get install -y fail2ban iptables"
sudo apt-get install -y fail2ban iptables
echo ""
echo "$ sudo systemctl enable fail2ban"
sudo systemctl enable fail2ban
echo ""
echo ""
echo ""
cd ~/Apps
echo "==============================================================================="
echo "   • Mise à jour des logiciels"
echo "==============================================================================="
echo ""
echo "-> autoupdate.sh :              [INSTALLÉ]"
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
echo ""
echo ""
if [[ -d "/etc/fail2ban" ]]; then
	echo "-> Fail2ban :                   [INSTALLÉ]"
	echo ""
	echo "$ sudo rm -rv /etc/fail2ban/jail.conf"
	sudo rm -rv /etc/fail2ban/jail.conf
	echo ""
	if [[ -d "/etc/pihole" ]]; then
    	echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/fail2ban/jail_lighttpd.conf > jail.conf"
	    wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/fail2ban/jail_lighttpd.conf > jail.conf
	else
	    echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/fail2ban/jail_sshd.conf > jail.conf"
	    wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/fail2ban/jail_sshd.conf > jail.conf
	fi
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
	echo "$ sudo systemctl --no-pager status fail2ban"
	sudo systemctl --no-pager status fail2ban
	echo ""
	sleep 1
	echo ""
	echo "$ sudo iptables -L -n"
	sudo iptables -L -n
else
	echo "-> Fail2ban :                   [NON INSTALLÉ]"
fi
echo ""
echo ""
echo ""
if [[ -d "/etc/pihole" ]]; then
	echo "-> Pi-hole :                    [INSTALLÉ]"
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
else
	echo "-> Pi-hole :                    [NON INSTALLÉ]"
	echo ""
fi
echo ""
echo ""
echo "==============================================================================="
echo "   • Configuration du crontab"
echo "==============================================================================="
echo ""
echo "Ancien crontab :"
crontab -l
echo ""
if [[ -f "/home/pi/Apps/backup.sh" ]]; then
	crontab <<<"0 3 * * * /home/pi/Apps/autoupdate.sh > /home/pi/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
30 3 * * * /home/pi/Apps/backup.sh
0 4 * * 0 sudo reboot"
else
	crontab <<<"0 3 * * * /home/pi/Apps/autoupdate.sh > /home/pi/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
0 4 * * 0 sudo reboot"
fi
sudo /etc/init.d/cron restart
echo ""
echo "Nouveau crontab :"
crontab -l
echo ""
echo ""
echo ""
echo "==============================================================================="
echo "   • Nettoyage et optimisation"
echo "==============================================================================="
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
		echo "$ find test*.log -exec rm -rv {} \;"
		find test*.log -exec rm -rv {} \;
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
sleep 1
#sudo reboot
