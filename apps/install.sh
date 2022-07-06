#!/bin/bash
clear
cd
echo "+=============================================================================+"
echo "|                         Pi-Hole Host Project Updater                        |"
echo "|                                 install.sh                                  |"
echo "|                                   [1097]                                    |"
echo "|                © 2020-2022 iDépanne – L'expert informatique                 |"
echo "|                            idepanne67@gmail.com                             |"
echo "+=============================================================================+"
echo ""
echo ""
echo ""

###### Définition des variables ######
varsys=$(cat /etc/os-release | grep PRETTY_NAME | cut -c14- | rev | cut -c2- | rev)
var0=$(cat /proc/cpuinfo | grep Model)
var20=$(ls /usr/bin/*session)
######################################

if [[ $varsys == *"MANJARO"* || $varsys == *"Manjaro"* ]]; then
	echo "Ce programme d'installation ne fonctionne qu'avec Raspberry Pi OS."
	echo "Il n'est pas compatible avec $varsys."
	echo ""
	cd
	sudo rm install.sh
else
	if [[ $var0 == *"Raspberry Pi"* ]]; then

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
		echo "$ sudo apt list --upgradable"
        sudo apt list --upgradable
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
		echo "$ cd"
		cd
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
		echo "$ cd ~/Apps"
		cd ~/Apps
		echo ""
		if [[ $var20 == *"lxsession"* || $var20 == *"openbox"* || $var20 == *"pipewire-media"* || $var20 == *"xfce"* || $var20 == *"gnome"* || $var20 == *"kde"* || $var20 == *"cinnamon"* || $var20 == *"mate"* ]]; then
			sleep 1
		else
			echo "$ mkdir log"
			mkdir log
			echo ""
		fi
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
		echo "$ cd"
		cd
		echo ""
		echo ""
		echo ""
		echo "+=============================================================================+"
		echo "|  • Installation des logiciels (CLI)                                         |"
		echo "+=============================================================================+"
		echo ""
		echo "$ sudo apt-get install -y ca-certificates git binutils dnsutils debian-goodies iftop whois traceroute curl fail2ban iptables speedtest-cli userconf-pi speedometer"
		sudo apt-get install -y ca-certificates git binutils dnsutils debian-goodies iftop whois traceroute curl fail2ban iptables speedtest-cli userconf-pi speedometer
		echo ""
		echo "$ curl https://rclone.org/install.sh | sudo bash"
		curl https://rclone.org/install.sh | sudo bash
		rclone version
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
		echo "$ sudo systemctl --no-pager status fail2ban"
		sudo systemctl --no-pager status fail2ban
		echo ""
		sleep 3
		echo "$ sudo iptables -L -n"
		sudo iptables -L -n
		echo ""
		echo "$ sudo fail2ban-client status sshd"
		sudo fail2ban-client status sshd
		echo ""
		echo ""
		echo ""
		if [[ $var20 == *"lxsession"* || $var20 == *"openbox"* || $var20 == *"pipewire-media"* || $var20 == *"xfce"* || $var20 == *"gnome"* || $var20 == *"kde"* || $var20 == *"cinnamon"* || $var20 == *"mate"* ]]; then
			echo "+=============================================================================+"
			echo "|  • Installation des logiciels (GUI)                                         |"
			echo "+=============================================================================+"
			echo ""
			echo "$ sudo apt-get install -y libreoffice libreoffice-l10n-fr libreoffice-help-fr hyphen-fr libreoffice-style* libreoffice-nlpsolver libreoffice-gnome* chromium-browser chromium-browser-l10n filezilla gparted hardinfo baobab hplip cups system-config-printer simple-scan gimagereader tesseract-ocr-fra hunspell-fr rpi-imager vlc meld gnome-system-monitor"
			sudo apt-get install -y libreoffice libreoffice-l10n-fr libreoffice-help-fr hyphen-fr libreoffice-style* libreoffice-nlpsolver libreoffice-gnome* chromium-browser chromium-browser-l10n filezilla gparted hardinfo baobab hplip cups system-config-printer simple-scan gimagereader tesseract-ocr-fra hunspell-fr rpi-imager vlc meld gnome-system-monitor
		else
			echo "+=============================================================================+"
			echo "|  • Installation de autoupdate.sh                                            |"
			echo "+=============================================================================+"
			echo ""
			echo "$ cd ~/Apps"
			cd ~/Apps
			echo ""
			echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate.sh > autoupdate.sh"
			wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate.sh > autoupdate.sh
			echo ""
			echo "$ sudo chmod +x autoupdate.sh"
			sudo chmod +x autoupdate.sh
			echo ""
			echo "$ cd"
			cd
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
				crontab <<<"0 3 * * * ~/Apps/autoupdate.sh > ~/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
30 3 * * * ~/Apps/backup.sh
0 4 * * 1 sudo reboot"
			else
				crontab <<<"0 3 * * * ~/Apps/autoupdate.sh > ~/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
0 4 * * 1 sudo reboot"
			fi
			sudo /etc/init.d/cron restart
			echo ""
			echo "Nouveau crontab :"
			crontab -l
		fi
		echo ""
		echo ""
		echo ""
		echo "+=============================================================================+"
		echo "|  • Nettoyage et optimisation                                                |"
		echo "+=============================================================================+"
		echo ""
		cd
		echo "Avant nettoyage :"
		sudo du -h /var/cache/apt/
		if [[ -d ".local/share/Trash/" ]]; then
			sudo du -h ~/.local/share/Trash/
		fi
		if [[ -d ".cache/thumbnails/" ]]; then
			sudo du -h ~/.cache/thumbnails/
		fi
		echo ""
		echo "$ cd"
		cd
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
		echo "$ sudo apt-mark auto $(apt-mark showmanual | egrep 'linux-.*[0-9]')"
		sudo apt-mark auto $(apt-mark showmanual | egrep 'linux-.*[0-9]')
		echo ""
		cd
		if [[ -d "Apps" ]]; then
			echo "$ cd ~/Apps"
			cd ~/Apps
			echo ""
			echo "$ sudo rm -rv *_old.sh"
			sudo rm -rv *_old.sh
			echo ""
			cd
			if [[ -d "Apps/log" ]]; then
				echo "$ cd ~/Apps/log"
				cd ~/Apps/log
				echo ""
				echo "$ find *.log -mtime +31 -exec rm -rv {} \;"
				find *.log -mtime +31 -exec rm -rv {} \;
				echo ""
			fi
		fi
		cd
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
		cd
		if [[ -d ".cache/thumbnails/" ]]; then
			echo "$ sudo rm -rfv ~/.cache/thumbnails/*"
			sudo rm -rfv ~/.cache/thumbnails/*
			echo ""
		fi
		cd
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
		echo "Ce programme d'installation ne fonctionne qu'avec Raspberry Pi OS."
		echo "Il n'est pas compatible avec $varsys."
		echo ""
		cd
		sudo rm install.sh
	fi
fi
