#!/bin/bash
cd ~/Apps || return
echo "+=============================================================================+"
echo "|                         Pi-Hole Host Project Updater                        |"
echo "|                                autoupdate.sh                                |"
echo "|                                   [1357]                                    |"
echo "|                © 2019-2024 iDépanne – L'expert informatique                 |"
echo "|                        idepanne.support.tech@free.fr                        |"
echo "+=============================================================================+"
echo ""
echo ""
echo ""

###### Définition des variables ######
varsys=$(< /etc/os-release grep PRETTY_NAME | cut -c14- | rev | cut -c2- | rev)
var0=$(< /proc/cpuinfo grep Model)
######################################

if [[ $varsys == *"MANJARO"* || $varsys == *"Manjaro"* ]]; then
	echo "Ce programme de mise à jour ne fonctionne qu'avec Raspberry Pi OS Lite (Debian 11 et 12)."
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
		if ping -c 3 1.1.1.1; echo ""; ping -c 3 2606:4700:4700::1111; then
			echo ""
			echo ""
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
			echo ""
			echo "Connexion Internet : Echec"
			echo ""
			echo ""
			echo "*** Abandon des mises à jour | Nouvelle tentative dans 24h ***"
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
                if [[ -f "Apps/email.sh" ]]; then
                    crontab <<<"0 0 1 * * ~/Apps/email.sh > ~/Apps/log/$(hostname -s)_$(date --date= +"%Y%m")_email_automate.txt 2>&1 ; sleep 5 ; echo 'Fichier log envoi emails' | mail -s '$(hostname -s)' -A ~/Apps/log/$(hostname -s)_$(date --date= +"%Y%m")_email_automate.txt idepanne.support.tech@free.fr
0 1 * * * ~/Apps/autoupdate.sh > ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_autoupdate.txt 2>&1 ; sleep 5 ; ~/Apps/resume.sh > ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_resume.txt 2>&1 ; sleep 5 ; echo 'Fichiers logs de $(hostname -s)' | mail -s '$(hostname -s)' -A ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_autoupdate.txt -A ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_resume.txt idepanne.support.tech@free.fr ; sleep 5 ; ~/Apps/backup.sh >/dev/null 2>&1
15 1 * * 1,4 sudo reboot >/dev/null 2>&1"
                else
                    if [[ -f "Apps/backup.sh" ]]; then
                        crontab <<<"0 1 * * * ~/Apps/autoupdate.sh > ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_autoupdate.txt 2>&1 ; sleep 5 ; ~/Apps/resume.sh > ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_resume.txt 2>&1 ; sleep 5 ; echo 'Fichiers logs de $(hostname -s)' | mail -s '$(hostname -s)' -A ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_autoupdate.txt -A ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_resume.txt idepanne.support.tech@free.fr ; sleep 5 ; ~/Apps/backup.sh >/dev/null 2>&1
15 1 * * 1,4 sudo reboot >/dev/null 2>&1"
                    else
                        crontab <<<"0 1 * * * ~/Apps/autoupdate.sh > ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_autoupdate.txt 2>&1 ; sleep 5 ; ~/Apps/resume.sh > ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_resume.txt 2>&1 ; sleep 5 ; echo 'Fichiers logs de $(hostname -s)' | mail -s '$(hostname -s)' -A ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_autoupdate.txt -A ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_resume.txt idepanne.support.tech@free.fr
15 1 * * 1,4 sudo reboot >/dev/null 2>&1"
                    fi
                fi
                sudo /etc/init.d/cron restart
                echo ""
                echo "Nouveau crontab :"
                crontab -l
			fi
		fi
		echo ""
		echo ""
		echo ""
		echo "+=============================================================================+"
		echo "|                    Mise à jour du Raspberry Pi terminée                     |"
		echo "+=============================================================================+"
	else
		echo "Ce programme de mise à jour ne fonctionne qu'avec Raspberry Pi OS Lite (Debian 11 et 12)."
		echo "Il n'est pas compatible avec $varsys."
		echo ""
		cd || return
		sudo rm autoupdate.sh
	fi
fi
