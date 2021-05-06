#!/bin/bash
#SECONDS=0
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
	var=$(find /home/pi/config.txt -exec grep -H 'beta=' {} \;)
	echo "$var"
	echo ""
	echo ""
	if [[ "$var" =~ "beta=1" ]]; then
		echo "Mises à jour \"Beta\""
		#echo ""
		#echo "$ sudo mv updater6.sh updater6_old.sh"
		#sudo mv updater6.sh updater6_old.sh
		#echo ""
		#echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/beta/beta_updater6.sh > updater6.sh"
		#wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/beta/beta_updater6.sh > updater6.sh
		#echo ""
		#echo "$ sudo chmod +x updater6.sh"
		#sudo chmod +x updater6.sh
		#./updater6.sh
	else
		echo "Mises à jour \"Release\""
		#echo ""
		#echo "$ sudo mv updater6.sh updater6_old.sh"
		#sudo mv updater6.sh updater6_old.sh
		#echo ""
		#echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/release/release_updater6.sh > updater6.sh"
		#wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/release/release_updater6.sh > updater6.sh
		#echo ""
		#echo "$ sudo chmod +x updater6.sh"
		#sudo chmod +x updater6.sh
		#./updater6.sh
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
	#duration=$SECONDS
	#echo "Durée d'exécution : $(($duration / 60)) min $(($duration % 60)) sec"
fi