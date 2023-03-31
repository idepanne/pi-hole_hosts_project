#!/bin/bash
cd ~/Apps || return
echo "+=============================================================================+"
echo "|                         Pi-Hole Host Project Updater                        |"
echo "|                                autoupdate.sh                                |"
echo "|                                   [1211]                                    |"
echo "|                © 2020-2023 iDépanne – L'expert informatique                 |"
echo "|                        idepanne.support.tech@free.fr                        |"
echo "+=============================================================================+"
echo ""
echo ""
echo ""

###### Définition des variables ######
varsys=$(< /etc/os-release grep PRETTY_NAME | cut -c14- | rev | cut -c2- | rev)
var0=$(< /proc/cpuinfo grep Model)
var20=$(ls /usr/bin/*session)
######################################

if [[ $varsys == *"MANJARO"* || $varsys == *"Manjaro"* ]]; then
	echo "Ce programme de mise à jour ne fonctionne qu'avec Raspberry Pi OS."
	echo "Il n'est pas compatible avec $varsys."
	echo ""
	cd || return
	sudo rm autoupdate.sh
else
	if [[ $var0 == *"Raspberry Pi"* ]]; then
		echo "+=============================================================================+"
		echo "|  • Test de la connexion Internet                                            |"
		echo "+=============================================================================+"
		echo ""
		echo ""
		if ping -c 3 1.1.1.1 &> /dev/null; then
			echo "Connexion Internet : OK"
			echo ""
			echo ""
			echo ""
			wget -O - https://raw.githubusercontent.com/idepanne/infosys/master/infosys-rpi.sh > infosys-rpi.sh && sudo chmod +x infosys-rpi.sh && ./infosys-rpi.sh
			echo ""
			echo "+=============================================================================+"
			echo "|  • Vérification des connexions actives                                      |"
			echo "+=============================================================================+"
			echo ""
			netstat -t | grep 'ESTABLISHED'
			echo ""
			echo ""
			echo ""
			echo "+=============================================================================+"
			echo "|  • Mise à jour de updater.sh                                                |"
			echo "+=============================================================================+"
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
			if [[ $var20 == *"lxsession"* || $var20 == *"openbox"* || $var20 == *"pipewire-media"* || $var20 == *"xfce"* || $var20 == *"gnome"* || $var20 == *"kde"* || $var20 == *"cinnamon"* || $var20 == *"mate"* ]]; then
				sleep
			else
				cd || return
				if [[ -d "Apps" ]]; then
					echo ""
					echo ""
					echo ""
					echo "+=============================================================================+"
					echo "|  • Configuration du crontab                                                 |"
					echo "+=============================================================================+"
					echo ""
					echo "Ancien crontab :"
					crontab -l
					echo ""
					if [[ -f "Apps/backup.sh" ]]; then
	                    crontab <<<"0 1 * * * ~/Apps/autoupdate.sh > ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_autoupdate.txt 2>&1 ; sleep 5 ; echo ' ' | mail -s '$(hostname -s) | $(date --date="+1day" +"%d/%m/%Y")' -A ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_autoupdate.txt idepanne.support.tech@free.fr ; sleep 5 ; ~/Apps/backup.sh > /dev/null 2>&1
15 1 * * 1 sudo reboot"
                    else
                       	crontab <<<"0 1 * * * ~/Apps/autoupdate.sh > ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_autoupdate.txt 2>&1 ; sleep 5 ; echo ' ' | mail -s '$(hostname -s) | $(date --date="+1day" +"%d/%m/%Y")' -A ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_autoupdate.txt idepanne.support.tech@free.fr
15 1 * * 1 sudo reboot"
                    fi
					sudo /etc/init.d/cron restart
					echo ""
					echo "Nouveau crontab :"
					crontab -l
				fi
			fi
		fi
		echo ""
		echo ""
		echo ""
		echo "+=============================================================================+"
		echo "|                    Mise à jour du Raspberry Pi terminée                     |"
		echo "+=============================================================================+"
		sleep 1
	else
		echo "Ce programme de mise à jour ne fonctionne qu'avec Raspberry Pi OS."
		echo "Il n'est pas compatible avec $varsys."
		echo ""
		cd || return
		sudo rm autoupdate.sh
	fi
fi
