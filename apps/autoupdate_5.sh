#!/bin/bash
SECONDS=0
cd
echo "                   'o:::::::::::::::::::::lc                                   "
echo "                   lc                     .O                                   "
echo "                   lc   ;cccl'   'll;:ll' .O                                   "
echo "                   lc  dMMMMMk   oMMOXMMl .O                                   "
echo "      cXMNd        lc  dMMMMMx   cKKdOKKc .O :d:::::::oo                       "
echo "      OMMMN.       lc   dXKXK:   cXXx0XXc .O o:       'k  .,,,.                "
echo "       ;l:.        lc                     .O o:       'k .0...0.               "
echo "  ,OOOOOOOkxo;.    cx,,,,,,,,,,,,,,,,,,,,,ck o: .''.  'k .O . O.               "
echo "  cMMxccccldKMWd    .........x;''x.........  o:       'k .O   O.               "
echo "  cMM,       ;XMO      od.  ;xxddxl          ,o:::::::lc  l:::c                "
echo "  cMM, :d:    :MM;    lx.                                                      "
echo "  cMM, kMk    'MMc .xOxxOk' .K0kxxOx.  lOkxk0k. 'XOkxOKd  ;XkkxOKd  .oOkxkO:   "
echo "  cMM, kMk    :MM;.WK'...0W..WN'   0N..l; ..dMl ,M0   oMc :Mx   kM: 0W:...dMl  "
echo "  cMM, kMk   'XMO ;MKdddddd..W0    xM'.kKOkdkMl ,Mx   cMl :Mc   dMc.NNdddddd:  "
echo "  cMM, kMKco0MWx  .KX,  .OO..WWl  ;NO xMd  .kMo ,Mx   cMl :Mc   dMc dWl. .oK,  "
echo "  ;00. o000kd:.     cxOOkl. .WNdkOx:  .lkkkd:xl .k:   ,k, 'k,   :k,  ,dOOOd'   "
echo "                            .WX                                                "
echo "           .                 c:   .     ''                  .                  "
echo "       l  .,.;:',,';. .;;.;,.d:'  ;..,.:d;'' ,,';.:,. .;..d,:' ': '.'.:,       "
echo "       o..  dc:'kc:d:ckc:lc .o,   l,ko:ll.d:lx  Ocd;lcldd.d.'cocx:olld::       "
echo "       ...  .'..:cco..,:...  ..   .  . ., .. .  ' . ... . .  .'.:.. ..'        "
echo "            .lc;.                                                              "
echo "                                                                               "
echo "                                                                               "
echo "                                                                               "
echo "                                                                               "
echo "                            autoupdate_5.sh 5.0.0b3                            "
echo "                 © 2020-2021 iDépanne – L'expert informatique                  "
echo "                            https://fb.me/idepanne/                            "
echo "                                                                               "
echo "                                                                               "
echo "                                                                               "
echo "-------------------------------------------------------------------------------"
echo "                         Test de la connexion Internet                         "
echo "-------------------------------------------------------------------------------"
echo ""
var=$(ping -c 3 raw.githubusercontent.com)
echo "$var"
echo ""
echo ""
if [[ "$var" =~ "0% packet loss" ]]; then
	echo "Connexion Internet: OK"
	echo ""
	echo ""
	echo ""
	echo "-------------------------------------------------------------------------------"
	echo "                              Informations système                             "
	echo "-------------------------------------------------------------------------------"
	echo ""
	cat /proc/cpuinfo | grep Model
	cat /proc/cpuinfo | grep Serial
	echo ""
	var1=$(lscpu | grep "Model name:" | sed -r 's/Model name:\s{1,}//g')
	var2=$(lscpu | grep "Vendor ID:" | sed -r 's/Vendor ID:\s{1,}//g')
	echo -n "Processeur      : " && echo "$var2 $var1"
	cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
	cpuTemp1=$(($cpuTemp0/1000))
	cpuTemp2=$(($cpuTemp0/100))
	cpuTempM=$(($cpuTemp2 % $cpuTemp1))
	echo -n "Température     : "; echo CPU temp"="$cpuTemp1"."$cpuTempM"'C"
	echo -n "                  "; echo GPU $(/opt/vc/bin/vcgencmd measure_temp)
	echo ""
	echo -n "Firmware        : "
	/opt/vc/bin/vcgencmd version
	echo ""
	echo -n "EEPROM          : "
	sudo rpi-eeprom-update
	echo ""
	echo -n "Système         : "; uname -sr
	echo -n "IPv4/IPv6       : "; hostname -I
	echo ""
	var3=$(uptime -s)
	var4=$(uptime -p)
	echo -n "Démarré depuis  : " && echo "$var3 - $var4"
	echo ""
	echo "Synchronisation de l'horloge :"
	sudo systemctl daemon-reload
	timedatectl timesync-status && timedatectl
	echo ""
	echo "Stockage        : "
	df -h /
	df -h | grep /var/log
	echo ""
	echo "RAM             : "
	free -ht
	echo ""
	echo ""
	echo ""
	echo "-------------------------------------------------------------------------------"
	echo "                            Mises à jour du système                            "
	echo "-------------------------------------------------------------------------------"
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
	echo "$ sudo pihole -up"
	var=$(sudo pihole -up)
		echo "$var"
		if [[ "$var" =~ "update available" ]]; then
			echo ""
		else
			echo ""
			echo "$ sudo pihole -g"
			# sudo pihole -g
			echo ""
		fi
	echo ""
	echo ""
	echo ""
	echo "-------------------------------------------------------------------------------"
	echo "                     Mise à jour du module autoupdate_5.sh                     "
	echo "-------------------------------------------------------------------------------"
	echo ""
	echo "wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate_5.sh > autoupdate_5_new.sh"
	wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate_5.sh > autoupdate_5_new.sh
	echo ""
	echo "sudo mv autoupdate_5.sh autoupdate_5_old.sh"
	sudo mv autoupdate_5.sh autoupdate_5_old.sh
	echo "sudo mv autoupdate_5_new.sh autoupdate_5.sh"
	sudo mv autoupdate_5_new.sh autoupdate_5.sh
	echo "sudo chmod +x autoupdate_5.sh"
	sudo chmod +x autoupdate_5.sh
	echo ""
	echo ""
	echo ""
	echo "-------------------------------------------------------------------------------"
	echo "                             Mise à jour du crontab                            "
	echo "-------------------------------------------------------------------------------"
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
	echo "-------------------------------------------------------------------------------"
	echo "                              Nettoyage du système                             "
	echo "-------------------------------------------------------------------------------"
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
	echo "sudo rm -rv *_old.sh"
	sudo rm -rv *_old.sh
	echo ""
	echo "sudo rm -rv *_new.sh"
	sudo rm -rv *_new.sh
	echo ""
	echo "sudo rm -rv *test*.sh"
	sudo rm -rv *test*.sh
	echo ""
	echo "cd /home/pi/log/ && sudo rm -rv *test*.log"
	cd /home/pi/log/ && sudo rm -rv *test*.log
	cd
	echo ""
	echo "find /home/pi/log/* -mtime +31 -exec rm -rv {} \;"
	find /home/pi/log/* -mtime +31 -exec rm -rv {} \;
	echo ""
	echo ""
	echo ""
	echo "-------------------------------------------------------------------------------"
	echo "                     Recherche du programme d'installation                     "
	echo "-------------------------------------------------------------------------------"
	echo ""
	var="$(find . -name 'install*')"
	if [ "$var" == "" ]; then
		echo "Programme d'installation non détecté"
		echo "$var"
		echo ""
		echo ""
		echo ""
		echo "-------------------------------------------------------------------------------"
		echo "                   Vérification des processus de mises à jour                  "
		echo "-------------------------------------------------------------------------------"
		echo ""
		var=$(sudo checkrestart)
		if [ "$var" = "Found 0 processes using old versions of upgraded files" ]; then
				echo "$var"
				echo ""
				echo ""
				echo ""
				echo "-------------------------------------------------------------------------------"
				echo "                          Aucun redémarrage nécessaire                         "
				echo "-------------------------------------------------------------------------------"
				echo ""
				echo ""
				echo ""
				duration=$SECONDS
				echo "Durée d'execution du programme: $(($duration / 60)) min $(($duration % 60)) sec"
		else
				echo "$var"
				echo ""
				echo ""
				echo ""
				echo "-------------------------------------------------------------------------------"
				echo "                          Redémarrage du Raspberry Pi                          "
				echo "-------------------------------------------------------------------------------"
				echo ""
				echo ""
				echo ""
				duration=$SECONDS
				echo "Durée d'execution du programme: $(($duration / 60)) min $(($duration % 60)) sec"
				echo ""
				sleep 1
				sudo reboot
		fi
	else
		echo "Programme d'installation détecté..."
		echo "$var"
		echo ""
		echo "sudo rm -rv install*"
		sudo rm -rv install*
		echo ""
		echo ""
		echo ""
		echo "-------------------------------------------------------------------------------"
		echo "             Redémarrage et vérification de la structure du disque             "
		echo "-------------------------------------------------------------------------------"
		echo ""
		echo ""
		echo ""
		duration=$SECONDS
		echo "Durée d'execution du programme: $(($duration / 60)) min $(($duration % 60)) sec"
		echo ""
		sleep 1
		sudo shutdown -rF now
	fi
else
	echo "Connexion Internet: Echec"
	echo ""
	echo ""
	echo "*** Abandon des mises à jour - Nouvelle tentative dans 24h ***"
	echo ""
	echo ""
	echo ""
	echo "-------------------------------------------------------------------------------"
	echo "                             Mise à jour du crontab                            "
	echo "-------------------------------------------------------------------------------"
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
	echo "Durée d'execution du programme: $(($duration / 60)) min $(($duration % 60)) sec"
	echo ""
fi
