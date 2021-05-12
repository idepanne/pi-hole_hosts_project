#!/bin/bash
# Pi-Hole Host Project Updater 6.0.2
# updater.sh
# © 2020-2021 iDépanne – L'expert informatique
# https://fb.me/idepanne/
# idepanne67@gmail.com
cd
echo ""
echo ""
echo ""
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
	echo "-> Fail2ban :           [INSTALLÉ]"
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
	echo "$ sudo systemctl --no-pager status fail2ban"
	sudo systemctl --no-pager status fail2ban
else
	echo "-> Fail2ban :           [NON INSTALLÉ]"
fi
echo ""
echo ""
echo ""
if [[ -d "/etc/pihole" ]]; then
	echo "-> Pi-hole :            [INSTALLÉ]"
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
	echo "-> Pi-hole :            [NON INSTALLÉ]"
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
crontab <<<"0 3 * * * /home/pi/autoupdate.sh > /home/pi/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1"
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
echo "$ sudo apt-get autoremove -y"
sudo apt-get autoremove -y
echo ""
echo "$ sudo apt-get autoclean -y"
sudo apt-get autoclean -y
echo ""
echo "$ sudo apt-get clean -y"
sudo apt-get clean -y
echo ""
cd
echo "$ sudo rm -rv *_old.sh"
sudo rm -rv *_old.sh
echo ""
echo "$ cd log && find test*.log -exec rm -rv {} \;"
cd log && find test*.log -exec rm -rv {} \;
cd
echo ""
echo "$ cd log && find *.log -mtime +31 -exec rm -rv {} \;"
cd log && find *.log -mtime +31 -exec rm -rv {} \;
cd
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
	if [[ -d "/etc/boinc-client" ]]; then
		var=$(hostname)
		echo "==============================================================================="
		echo "   • Redémarrage du noeud \"$var\" dans le cluster Boinc"
		echo "==============================================================================="
		echo ""
		echo "$ sudo systemctl start boinc-client"
		sudo systemctl start boinc-client
		sleep 1
		echo ""
		echo ""
		echo ""
	fi
	echo "###############################################################################"
	echo "#                                                                             #"
	echo "#                Aucun redémarrage du Raspberry Pi nécessaire                 #"
	echo "#                                                                             #"
	echo "###############################################################################"
	echo ""
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