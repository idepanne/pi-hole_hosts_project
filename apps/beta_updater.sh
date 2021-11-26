#!/bin/bash
# Pi-Hole Host Project Updater 7.0.5b1
# beta_updater.sh
# © 2020-2021 iDépanne – L'expert informatique
# https://fb.me/idepanne/
# idepanne67@gmail.com
echo ""
echo ""
echo ""
cd ~/Apps
echo "==============================================================================="
echo "   • Mises à jour de Raspberry Pi OS"
echo "==============================================================================="
echo ""
echo "$ sudo apt-get update"
sudo apt-get update
echo ""
echo "$ sudo apt-get upgrade -y"
sudo apt-get upgrade -y
echo ""
echo "$ sudo apt-get dist-upgrade -y"
sudo apt-get dist-upgrade -y
echo ""
echo "$ sudo apt-get full-upgrade -y"
sudo apt-get full-upgrade -y
echo ""
echo ""
echo ""
echo "==============================================================================="
echo "   • Mises à jour des logiciels"
echo "==============================================================================="
echo ""
echo "-> autoupdate.sh :           [INSTALLÉ]"
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
if [[ -d "/etc/pihole" ]]; then
	echo "-> Pi-hole :                 [INSTALLÉ]"
	echo ""
	sudo pihole -v
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
	echo "-> Pi-hole :                 [NON INSTALLÉ]"
fi
echo ""
echo ""
echo ""
echo "==============================================================================="
echo "   • Mise à jour du crontab"
echo "==============================================================================="
echo ""
echo "Ancien crontab :"
crontab -l
echo ""
var20=$(ls /usr/bin/*session)
if [[ $var20 == *"lxsession"* || $var1 == *"openbox"*  || $var1 == *"pipewire-media"* ]]; then
	crontab <<<"0 8 * * * /home/pi/Apps/autoupdate.sh > /home/pi/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
30 8 * * * /home/pi/Apps/backup.sh"
else
if [[ -f "/home/pi/Apps/backup.sh" ]]; then
	crontab <<<"0 3 * * * /home/pi/Apps/autoupdate.sh > /home/pi/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
30 3 * * * /home/pi/Apps/backup.sh"
else
	crontab <<<"0 3 * * * /home/pi/Apps/autoupdate.sh > /home/pi/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1"
fi
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
echo "Avant nettoyage :"
echo "$ sudo du -h /var/cache/apt/"
sudo du -h /var/cache/apt/
echo ""
echo "$ sudo apt-get autoremove -y"
sudo apt-get autoremove -y
echo ""
echo "$ sudo apt-get autoclean -y"
sudo apt-get autoclean -y
echo ""
echo "$ sudo apt-get clean all"
sudo apt-get clean all
echo ""
echo "$ cd ~/Apps"
cd ~/Apps
echo ""
echo "$ sudo rm -rv *_old.sh"
sudo rm -rv *_old.sh
echo ""
echo "$ cd ~/Apps/log && find test*.log -exec rm -rv {} \;"
cd ~/Apps/log && find test*.log -exec rm -rv {} \;
echo ""
echo "$ cd ~/Apps/log && find *.log -mtime +31 -exec rm -rv {} \;"
cd ~/Apps/log && find *.log -mtime +31 -exec rm -rv {} \;
echo ""
if [[ -d "/home/pi/.local/share/Trash/" ]]; then
echo "$ sudo rm -rfv ~/.local/share/Trash/files/*"
sudo rm -rfv ~/.local/share/Trash/files/*
echo ""
echo "$ sudo rm -rfv ~/.local/share/Trash/expunged/*"
sudo rm -rfv ~/.local/share/Trash/expunged/*
echo ""
echo "$ sudo rm -rfv ~/.local/share/Trash/info/*"
sudo rm -rfv ~/.local/share/Trash/info/*
fi
echo ""
echo "Après nettoyage :"
echo "$ sudo du -h /var/cache/apt/"
sudo du -h /var/cache/apt/
echo ""
echo ""
echo ""
echo "==============================================================================="
echo "   • Validation des mises à jour"
echo "==============================================================================="
echo ""
var=$(sudo checkrestart)
if [ "$var" = "Found 0 processes using old versions of upgraded files" ]; then
	echo "$var"
	echo ""
	echo ""
	echo ""
	echo "###############################################################################"
	echo "#                                                                             #"
	echo "#                Aucun redémarrage du Raspberry Pi nécessaire                 #"
	echo "#                                                                             #"
	echo "###############################################################################"
	echo ""
	sleep 1
else
	echo "$var"
	echo ""
	echo ""
	echo ""
	echo "###############################################################################"
	echo "#                                                                             #"
	echo "#                         Redémarrage du Raspberry Pi                         #"
	echo "#                                                                             #"
	echo "###############################################################################"
	echo ""
	sleep 1
	sudo reboot
fi