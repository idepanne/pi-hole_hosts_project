#!/bin/bash
SECONDS=0
cd
echo "###############################################################################"
echo "#                                                                             #"
echo "#                            autoupdate.sh 5.2.4                              #"
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
	echo "                              Informations système                             "
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
	df -h /
	df -h | grep /var/log
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
	echo "                        Vérification des connexions SSH                        "
	echo "==============================================================================="
	echo ""
	echo "netstat -tn 2>/dev/null | grep :22 | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head"
	netstat -tn 2>/dev/null | grep :22 | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head
	echo ""
	echo ""
	echo ""
	echo "==============================================================================="
	echo "                            Mises à jour du système                            "
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
	###############################################################################
	#                                A supprimer !                                #
	###############################################################################
	echo "$ sudo apt-get install -yf fail2ban"
	sudo apt-get install -yf fail2ban
	###############################################################################
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
	echo ""
	echo ""
	echo ""
	echo "==============================================================================="
	echo "                      Mise à jour du module autoupdate.sh                      "
	echo "==============================================================================="
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
	echo "                              Nettoyage du système                             "
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
	echo "$ sudo rm -rv *_old.sh"
	sudo rm -rv *_old.sh
	echo ""
	###############################################################################
	#                                A supprimer !                                #
	###############################################################################
	echo "$ sudo rm -rv pialert*"
	sudo rm -rv pialert*
	echo "$ sudo rm -rv backup*"
	sudo rm -rv backup*
	###############################################################################
	echo ""
	echo "cd log && find *.log -mtime +31 -exec rm -rv {} \; && cd"
	cd log && find *.log -mtime +31 -exec rm -rv {} \; && cd
	echo ""
	echo ""
	echo ""
	echo "==============================================================================="
	echo "                   Vérification des processus de mises à jour                  "
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