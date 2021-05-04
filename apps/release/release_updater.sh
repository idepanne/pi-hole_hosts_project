#!/bin/bash
SECONDS=0
cd
echo "###############################################################################"
echo "#                                                                             #"
echo "#                     Pi-Hole Host Project Updater 6.0.0b1                    #"
echo "#                 © 2020-2021 iDépanne – L'expert informatique                #"
echo "#                           https://fb.me/idepanne/                           #"
echo "#                            idepanne67@gmail.com                             #"
echo "#                                                                             #"
echo "###############################################################################"
echo ""
echo ""
echo ""
echo "==============================================================================="
echo "                         Test de la connexion Internet                         "
echo "==============================================================================="
echo ""
var=$(ping -c 3 raw.githubusercontent.com)
echo "$var"
echo ""
echo ""
if [[ "$var" =~ "0% packet loss" ]]; then
	echo "Connexion Internet : OK"
	echo ""
	echo ""
	echo ""
	echo "==============================================================================="
	echo "                          A propos de ce Raspberry Pi                          "
	echo "==============================================================================="
	echo ""
	cat /proc/cpuinfo | grep Model
	echo ""
	cat /proc/cpuinfo | grep Serial
	echo ""
	var1=$(lscpu | grep "Model name:" | sed -r 's/Model name:\s{1,}//g')
	var2=$(lscpu | grep "Vendor ID:" | sed -r 's/Vendor ID:\s{1,}//g')
	echo -n "Processeur      : " && echo "$var2 $var1"
	echo ""
	cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
	cpuTemp1=$(($cpuTemp0/1000))
	cpuTemp2=$(($cpuTemp0/100))
	cpuTempM=$(($cpuTemp2 % $cpuTemp1))
	echo -n "Température     : "; echo CPU "= "$cpuTemp1"."$cpuTempM"°C"
	echo -n "                  "; echo "GPU = $(vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*')°C"
	echo ""
	echo -n "Firmware        : "
	/opt/vc/bin/vcgencmd version
	echo ""
	echo -n "EEPROM          : "
	sudo rpi-eeprom-update
	echo ""
	echo -n "Système         : "; uname -sr
	echo ""
	echo -n "IPv4/IPv6       : "; hostname -I
	echo ""
	var3=$(uptime -s)
	var4=$(uptime -p)
	echo -n "Démarré depuis  : " && echo "$var3 - $var4"
	echo ""
	echo "Stockage        : "
	df -h
	echo ""
	echo "RAM             : "
	free -ht
	echo ""
	echo "Synchronisation de l'horloge :"
	sudo systemctl daemon-reload
	timedatectl timesync-status && timedatectl
	echo ""
	echo ""
	echo ""
	echo "==============================================================================="
	echo "                    Vérification des connexions SSH actives                    "
	echo "==============================================================================="
	echo ""
	netstat -tn 2>/dev/null | grep :22 | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head
	echo ""
	echo ""
	echo ""
	echo "==============================================================================="
	echo "                        Mises à jour de Raspberry Pi OS                        "
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
	echo "                           Mises à jour des logiciels                          "
	echo "==============================================================================="
	echo ""
	if [[ -f "/home/pi/autoupdate.sh" ]]; then
		echo "-> autoupdate.sh :      [INSTALLÉ]"
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
		echo "-> autoupdate.sh :      [NON INSTALLÉ]"
	fi
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
	echo "                             Mise à jour du crontab                            "
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
	echo "                           Nettoyage et optimisation                           "
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
	echo "$ sudo rm -rv test*.sh"
	sudo rm -rv test*.sh
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
	echo "                          Validation des mises à jour                          "
	echo "==============================================================================="
	echo ""
	var=$(sudo checkrestart)
	if [ "$var" = "Found 0 processes using old versions of upgraded files" ]; then
		echo "$var"
		echo ""
		echo ""
		echo ""
		echo "==============================================================================="
		echo "                          Aucun redémarrage nécessaire                         "
		echo "==============================================================================="
		echo ""
		echo ""
		echo ""
		duration=$SECONDS
		echo "Durée d'exécution : $(($duration / 60)) min $(($duration % 60)) sec"
	else
		echo "$var"
		echo ""
		echo ""
		echo ""
		echo "==============================================================================="
		echo "                          Redémarrage du Raspberry Pi                          "
		echo "==============================================================================="
		echo ""
		echo ""
		echo ""
		duration=$SECONDS
		echo "Durée d'exécution : $(($duration / 60)) min $(($duration % 60)) sec"
		echo ""
		sleep 1
		sudo reboot
	fi
else
	echo "Connexion Internet : Echec"
	echo ""
	echo ""
	echo "*** Abandon des mises à jour - Nouvelle tentative dans 24h ***"
	echo ""
	echo ""
	echo ""
	echo "==============================================================================="
	echo "                             Mise à jour du crontab                            "
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
	duration=$SECONDS
	echo "Durée d'exécution : $(($duration / 60)) min $(($duration % 60)) sec"
fi