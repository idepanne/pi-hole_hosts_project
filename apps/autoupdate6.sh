#!/bin/bash
cd
echo "###############################################################################"
echo "#                                                                             #"
echo "#                     Pi-Hole Host Project Updater 6.0.0b8                    #"
echo "#                 © 2020-2021 iDépanne – L'expert informatique                #"
echo "#                           https://fb.me/idepanne/                           #"
echo "#                            idepanne67@gmail.com                             #"
echo "#                                                                             #"
echo "###############################################################################"
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
	var=$(find /home/pi/config.txt -exec grep -H 'beta=' {} \;)
	if [[ "$var" =~ "beta=1" ]]; then
		echo "==============================================================================="
		echo "                   Sélection du canal de mises à jour : Beta                   "
		echo "==============================================================================="
		echo ""
		echo "$ sudo mv updater6.sh updater6_old.sh"
		sudo mv updater6.sh updater6_old.sh
		echo ""
		echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/beta/beta_updater6.sh > updater6.sh"
		wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/beta/beta_updater6.sh > updater6.sh
		echo ""
		echo "$ sudo chmod +x updater6.sh"
		sudo chmod +x updater6.sh
		./updater6.sh
	else
		echo "==============================================================================="
		echo "                 Sélection du canal de mises à jour : Release                  "
		echo "==============================================================================="
		echo ""
		echo "$ sudo mv updater6.sh updater6_old.sh"
		sudo mv updater6.sh updater6_old.sh
		echo ""
		echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/release/release_updater6.sh > updater6.sh"
		wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/release/release_updater6.sh > updater6.sh
		echo ""
		echo "$ sudo chmod +x updater6.sh"
		sudo chmod +x updater6.sh
		./updater6.sh
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
	crontab <<<"0 3 * * * /home/pi/autoupdate6.sh > /home/pi/log/`date --date="+1day" +"%Y%m%d"`_autoupdate6.log 2>&1"
	sudo /etc/init.d/cron restart
	echo ""
	echo "Nouveau crontab :"
	crontab -l
fi