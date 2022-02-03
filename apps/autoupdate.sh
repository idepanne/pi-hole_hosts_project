#!/bin/bash
cd ~/Apps
echo "###############################################################################"
echo "#                                                                             #"
echo "#                     Pi-Hole Host Project Updater 8.1.3b3                    #"
echo "#                                autoupdate.sh                                #"
echo "#                 © 2020-2022 iDépanne – L'expert informatique                #"
echo "#                           https://fb.me/idepanne/                           #"
echo "#                            idepanne67@gmail.com                             #"
echo "#                                                                             #"
echo "###############################################################################"
echo ""
echo ""
echo ""
echo "==============================================================================="
echo "   • Test de la connexion Internet"
echo "==============================================================================="
echo ""
var0=$(ping -c 3 1.1.1.1)
echo "$var0"
echo ""
echo ""
if [[ "$var0" =~ "0% packet loss" ]]; then
	echo "Connexion Internet : OK"
	echo ""
	echo ""
	echo ""
    wget -O - https://raw.githubusercontent.com/idepanne/infosys/master/infosys-rpi.sh > infosys-rpi.sh && sudo chmod +x infosys-rpi.sh && ./infosys-rpi.sh
    echo ""
    echo ""
    echo ""
    echo "==============================================================================="
    echo "   • Vérification des connexions actives"
    echo "==============================================================================="
    echo ""
    netstat -t | grep 'ESTABLISHED'
	echo ""
	echo ""
	echo ""
	echo "==============================================================================="
	echo "   • Mise à jour de updater.sh"
	echo "==============================================================================="
	echo ""
	echo "$ sudo mv updater.sh updater_old.sh"
	sudo mv updater.sh updater_old.sh
	echo ""
	echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/updater.sh > updater.sh"
	wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/updater.sh > updater.sh
	echo ""
	echo "$ sudo chmod +x updater.sh"
	sudo chmod +x updater.sh
	./updater.sh
else
	echo "Connexion Internet : Echec"
	echo ""
	echo ""
	echo "*** Abandon des mises à jour | Nouvelle tentative dans 24h ***"
	echo ""
	if [[ -d "/etc/pihole" ]]; then
		echo ""
		echo ""
		echo "==============================================================================="
		echo "   • Mise à jour du crontab"
		echo "==============================================================================="
		echo ""
		echo "Ancien crontab :"
		crontab -l
		echo ""
		if [[ -f "/home/pi/Apps/backup.sh" ]]; then
			crontab <<<"0 3 * * * /home/pi/Apps/autoupdate.sh > /home/pi/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
30 3 * * * /home/pi/Apps/backup.sh"
		else
			crontab <<<"0 3 * * * /home/pi/Apps/autoupdate.sh > /home/pi/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1"
		fi
		sudo /etc/init.d/cron restart
		echo ""
		echo "Nouveau crontab :"
		crontab -l
		echo ""
	fi
fi
echo ""
echo ""
echo "###############################################################################"
echo "#                                                                             #"
echo "#                    Mise à jour du Raspberry Pi terminée                     #"
echo "#                                                                             #"
echo "###############################################################################"
echo ""
sleep 1
