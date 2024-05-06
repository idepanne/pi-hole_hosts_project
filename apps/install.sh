#!/bin/bash
clear
cd || return
echo "+=============================================================================+"
echo "|                         Pi-Hole Host Project Updater                        |"
echo "|                                 install.sh                                  |"
echo "|                                   [1384]                                    |"
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
		wget -O - https://raw.githubusercontent.com/idepanne/infosys/master/infosys.sh > infosys.sh && sudo chmod +x infosys.sh && ./infosys.sh
		echo ""
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
		echo "|  • Mise à jour du noyau Linux (firmware)                                    |"
		echo "+=============================================================================+"
		echo ""
		echo "$ sudo wget https://raw.githubusercontent.com/Hexxeh/rpi-update/master/rpi-update"
		sudo wget https://raw.githubusercontent.com/Hexxeh/rpi-update/master/rpi-update
		echo ""
		echo "$ sudo mv rpi-update /usr/local/bin/rpi-update"
		sudo mv rpi-update /usr/local/bin/rpi-update
		echo "$ sudo chmod +x /usr/local/bin/rpi-update"
		sudo chmod +x /usr/local/bin/rpi-update
		echo ""
		echo "Version actuelle :"
		uname -srv
		echo ""
		echo "y = Version de test | N = Version stable"
		echo ""
		echo "$ sudo rpi-update"
		sudo rpi-update
		echo ""
		echo ""
		echo ""
		echo "+=============================================================================+"
		echo "|  • Mise à jour de l'EEPROM                                                  |"
		echo "+=============================================================================+"
		echo ""
		echo "$ sudo rpi-eeprom-update -a"
		sudo rpi-eeprom-update -a
		echo ""
		echo ""
		echo ""
		echo "+=============================================================================+"
		echo "|  • Mise à jour de Raspberry Pi OS                                           |"
		echo "+=============================================================================+"
		echo ""
		echo "$ sudo apt-get full-upgrade -y"
		sudo apt-get full-upgrade -y
		echo ""
		echo ""
		echo ""
		echo "+=============================================================================+"
		echo "|  • Préparation de l'installation                                            |"
		echo "+=============================================================================+"
		echo ""
		echo "$ cd || return"
		cd || return
		echo ""
		echo "$ sudo rm -rv install.sh"
		sudo rm -rv install.sh
		echo ""
		echo "$ sudo rm -rv infosys.sh"
		sudo rm -rv infosys.sh
		echo ""
		echo "$ sudo rm -rv infosys-rpi.sh"
		sudo rm -rv infosys-rpi.sh
		echo ""
		echo "$ mkdir Apps"
		mkdir Apps
		echo ""
		echo "$ cd ~/Apps || return"
		cd ~/Apps || return
		echo ""
		echo "$ mkdir log"
		mkdir log
		echo ""
		echo "$ sudo rm -rv install.sh"
		sudo rm -rv install.sh
		echo ""
		echo "$ sudo rm -rv infosys.sh"
		sudo rm -rv infosys.sh
		echo ""
		echo "$ sudo rm -rv infosys-rpi.sh"
		sudo rm -rv infosys-rpi.sh
		echo ""
		echo "$ sudo rm -rv autoupdate.sh"
		sudo rm -rv autoupdate.sh
		echo ""
		echo "$ sudo rm -rv updater.sh"
		sudo rm -rv updater.sh
		echo ""
		echo "$ sudo rm -rv resume.sh"
		sudo rm -rv resume.sh
		echo ""
		echo "$ cd || return"
		cd || return
		echo ""
		echo ""
		echo ""
		echo "+=============================================================================+"
		echo "|  • Installation des logiciels requis                                        |"
		echo "+=============================================================================+"
		echo ""
		echo "$ sudo apt-get install -y ca-certificates git binutils dnsutils debian-goodies whois traceroute curl lsb-release fail2ban iptables userconf-pi speedometer smartmontools mailutils ssmtp rsyslog"
		sudo apt-get install -y ca-certificates git binutils dnsutils debian-goodies whois traceroute curl lsb-release fail2ban iptables userconf-pi speedometer smartmontools mailutils ssmtp rsyslog
		echo ""
		echo "$ curl https://rclone.org/install.sh | sudo bash"
		curl https://rclone.org/install.sh | sudo bash
		rclone version
		echo ""
		FICHIER=/etc/fail2ban/jail.conf.bak
		if [ -f "$FICHIER" ]; then
			echo "Le fichier ($FICHIER) existe."
		else
			echo "Le fichier ($FICHIER) n'existe pas."
			echo ""
			echo "Sauvegarde du fichier de configuration"
			echo "$ sudo cp -v /etc/fail2ban/jail.conf /etc/fail2ban/jail.conf.bak"
			sudo cp -v /etc/fail2ban/jail.conf /etc/fail2ban/jail.conf.bak
		fi
		echo ""
		echo "$ sudo rm -rv /etc/fail2ban/jail.conf"
		sudo rm -rv /etc/fail2ban/jail.conf
		echo ""
		echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/fail2ban/jail.conf > jail.conf"
		wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/fail2ban/jail.conf > jail.conf
		echo ""
		echo "$ sudo mv jail.conf /etc/fail2ban/jail.conf"
		sudo mv jail.conf /etc/fail2ban/jail.conf
		echo ""
		echo "$ sudo chown root:root /etc/fail2ban/jail.conf"
		sudo chown root:root /etc/fail2ban/jail.conf
		echo ""
		echo "$ sudo service fail2ban restart"
		sudo service fail2ban restart
		echo ""
		sleep 3
		echo "$ sudo systemctl status --no-pager -l fail2ban.service"
		sudo systemctl status --no-pager -l fail2ban.service
		echo ""
		sleep 3
		echo "$ sudo iptables -L -n"
		sudo iptables -L -n
		echo ""
		echo "$ sudo fail2ban-client status sshd"
		sudo fail2ban-client status sshd
		echo ""
		echo "$ sudo rm -rv /etc/ssmtp/revaliases"
		sudo rm -rv /etc/ssmtp/revaliases
		echo ""
		echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/ssmtp/revaliases > revaliases"
		wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/ssmtp/revaliases > revaliases
		echo ""
		echo "$ sudo mv revaliases /etc/ssmtp/revaliases"
		sudo mv revaliases /etc/ssmtp/revaliases
		echo ""
		echo "$ sudo chown root:mail /etc/ssmtp/revaliases"
		sudo chown root:mail /etc/ssmtp/revaliases
		echo ""
		echo "$ sudo rm -rv /etc/ssmtp/ssmtp.conf"
		sudo rm -rv /etc/ssmtp/ssmtp.conf
		echo ""
		echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/ssmtp/ssmtp.conf > ssmtp.conf"
		wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/ssmtp/ssmtp.conf > ssmtp.conf
		echo ""
		echo "$ sudo mv ssmtp.conf /etc/ssmtp/ssmtp.conf"
		sudo mv ssmtp.conf /etc/ssmtp/ssmtp.conf
		echo ""
		echo "$ sudo chown root:mail /etc/ssmtp/ssmtp.conf"
		sudo chown root:mail /etc/ssmtp/ssmtp.conf
		echo ""
		echo ""
		echo ""
		echo "****************************** /!\ IMPORTANT /!\ ******************************"
		echo "*                                                                             *"
		echo "*          Ne pas oublier d'ajouter le mot de passe du compte e-mail          *"
		echo "*                   dans le fichier '/etc/ssmtp/ssmtp.conf'                   *"
		echo "*                                                                             *"
		echo "*******************************************************************************"
		sleep 5
		echo ""
		echo ""
		echo ""
		echo "+=============================================================================+"
		echo "|  • Installation de autoupdate.sh                                            |"
		echo "+=============================================================================+"
		echo ""
		echo "$ cd ~/Apps || return"
		cd ~/Apps || return
		echo ""
		echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate.sh > autoupdate.sh"
		wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate.sh > autoupdate.sh
		echo ""
		echo "$ sudo chmod +x autoupdate.sh"
		sudo chmod +x autoupdate.sh
		echo ""
		echo "$ cd || return"
		cd || return
		echo ""
		echo ""
		echo ""
		echo "+=============================================================================+"
		echo "|  • Installation de resume.sh                                                |"
		echo "+=============================================================================+"
		echo ""
		echo "$ cd ~/Apps || return"
		cd ~/Apps || return
		echo ""
		echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/resume.sh > resume.sh"
		wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/resume.sh > resume.sh
		echo ""
		echo "$ sudo chmod +x resume.sh"
		sudo chmod +x resume.sh
		echo ""
		echo "$ cd || return"
		cd || return
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
			crontab <<<"0 0 28 * * ~/Apps/email.sh > ~/Apps/log/$(hostname -s)_$(date --date='+1month' +'%Y%m')_email_automate.txt 2>&1 ; sleep 5 ; echo 'Fichier log envoi emails' | mail -s '$(hostname -s)' -A ~/Apps/log/$(hostname -s)_$(date --date='+1month' +'%Y%m')_email_automate.txt idepanne.support.tech@free.fr
0 1 * * * ~/Apps/autoupdate.sh > ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_autoupdate.txt 2>&1 ; sleep 5 ; ~/Apps/resume.sh > ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_resume.txt 2>&1 ; sleep 5 ; echo 'Fichiers logs de $(hostname -s)' | mail -s '$(hostname -s)' -A ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_autoupdate.txt -A ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_resume.txt idepanne.support.tech@free.fr ; sleep 5 ; ~/Apps/backup.sh >/dev/null 2>&1
15 1 * * 1,4 sudo reboot >/dev/null 2>&1"
		else
			if [[ -f "Apps/backup.sh" ]]; then
				crontab <<<"0 1 * * * ~/Apps/autoupdate.sh > ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_autoupdate.txt 2>&1 ; sleep 5 ; ~/Apps/resume.sh > ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_resume.txt 2>&1 ; sleep 5 ; echo 'Fichiers logs de $(hostname -s)' | mail -s '$(hostname -s)' -A ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_autoupdate.txt -A ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_resume.txt idepanne.support.tech@free.fr ; sleep 5 ; ~/Apps/backup.sh >/dev/null 2>&1
15 1 * * 1,4 sudo reboot >/dev/null 2>&1"
			else
				crontab <<<"0 1 * * * ~/Apps/autoupdate.sh > ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_autoupdate.txt 2>&1 ; sleep 5 ; ~/Apps/resume.sh > ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_resume.txt 2>&1 ; sleep 5 ; echo 'Fichiers logs de $(hostname -s)' | mail -s '$(hostname -s)' -A ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_autoupdate.txt -A ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_resume.txt idepanne.support.tech@free.fr
15 1 * * 1,4 sudo reboot >/dev/null 2>&1"
			fi
		fi
        sudo /etc/init.d/cron restart
        echo ""
        echo "Nouveau crontab :"
        crontab -l
		echo ""
		echo ""
		echo ""
		echo "+=============================================================================+"
		echo "|  • Nettoyage et optimisation                                                |"
		echo "+=============================================================================+"
		echo ""
		cd || return
		echo "Avant nettoyage :"
		sudo du -h /var/cache/apt/
		if [[ -d ".local/share/Trash/" ]]; then
			sudo du -h ~/.local/share/Trash/
		fi
		if [[ -d ".cache/thumbnails/" ]]; then
			sudo du -h ~/.cache/thumbnails/
		fi
		echo ""
		echo "$ cd || return"
		cd || return
		echo ""
		echo "$ sudo apt-get autopurge -y"
		sudo apt-get autopurge -y
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
		echo '$ sudo apt-mark auto $(apt-mark showmanual | grep -E 'linux-.*[0-9]')'
		sudo apt-mark auto $(apt-mark showmanual | grep -E 'linux-.*[0-9]')
		echo ""
		cd || return
		echo "$ sudo rm -rv dead.letter"
		sudo rm -rv dead.letter
		echo ""
		if [[ -d "Apps" ]]; then
			echo "$ cd ~/Apps || return"
			cd ~/Apps || return
			echo ""
			echo "$ sudo rm -rv *_old.sh"
			sudo rm -rv *_old.sh
			echo ""
			cd || return
			if [[ -d "Apps/log" ]]; then
				echo "$ cd ~/Apps/log || return"
				cd ~/Apps/log || return
				echo ""
				echo "$ find *.txt -mtime +31 -exec rm -rv {} \;"
				find *.txt -mtime +31 -exec rm -rv {} \;
				echo ""
			fi
		fi
		cd || return
		if [[ -d ".local/share/Trash/" ]]; then
			echo "$ sudo rm -rfv ~/.local/share/Trash/files/*"
			sudo rm -rfv ~/.local/share/Trash/files/*
			echo ""
			echo "$ sudo rm -rfv ~/.local/share/Trash/expunged/*"
			sudo rm -rfv ~/.local/share/Trash/expunged/*
			echo ""
			echo "$ sudo rm -rfv ~/.local/share/Trash/info/*"
			sudo rm -rfv ~/.local/share/Trash/info/*
			echo ""
		fi
		cd || return
		if [[ -d ".cache/thumbnails/" ]]; then
			echo "$ sudo rm -rfv ~/.cache/thumbnails/*"
			sudo rm -rfv ~/.cache/thumbnails/*
			echo ""
		fi
		cd || return
		echo "Après nettoyage :"
		sudo du -h /var/cache/apt/
		if [[ -d ".local/share/Trash/" ]]; then
			sudo du -h ~/.local/share/Trash/
		fi
		if [[ -d ".cache/thumbnails/" ]]; then
			sudo du -h ~/.cache/thumbnails/
		fi
		echo ""
		echo ""
		echo ""
		echo "+=============================================================================+"
		echo "|  • Validation des mises à jour                                              |"
		echo "+=============================================================================+"
		echo ""
		var100=$(sudo checkrestart)
		if [ "$var100" = "Found 0 processes using old versions of upgraded files" ]; then
			echo "$var100"
			echo ""
			echo ""
			echo ""
			echo "+=============================================================================+"
			echo "|                Aucun redémarrage du Raspberry Pi nécessaire                 |"
			echo "+=============================================================================+"
			sleep 1
		else
			echo "$var100"
			echo ""
			echo ""
			echo ""
			echo "+=============================================================================+"
			echo "|                         Redémarrage du Raspberry Pi                         |"
			echo "+=============================================================================+"
			sleep 1
			sudo reboot
		fi
	else
		echo ""
		echo "Connexion Internet : Echec"
		echo ""
		echo ""
		echo "*** Installation impossible sans connexion Internet ***"
	fi
else
	echo "Ce programme d'installation ne fonctionne qu'avec Raspberry Pi OS Lite (Debian 11 et 12)."
	echo "Il n'est pas compatible avec $varsys."
	echo ""
	cd || return
	sudo rm install.sh
fi
