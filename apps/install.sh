#!/bin/bash
clear
cd
echo "###############################################################################"
echo "#                                                                             #"
echo "#                     Pi-Hole Host Project Updater 8.2.0b4                    #"
echo "#                                  install.sh                                 #"
echo "#                 © 2020-2022 iDépanne – L'expert informatique                #"
echo "#                           https://fb.me/idepanne/                           #"
echo "#                            idepanne67@gmail.com                             #"
echo "#                                                                             #"
echo "###############################################################################"
echo ""
echo ""
echo ""
var0=$(cat /proc/cpuinfo | grep Model)
if [[ $var0 == *"Raspberry Pi"* ]]; then

wget -O - https://raw.githubusercontent.com/idepanne/infosys/master/infosys.sh > infosys.sh && sudo chmod +x infosys.sh && ./infosys.sh
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
echo "   • Mise à jour du firmware"
echo "==============================================================================="
echo ""
echo "$ sudo wget https://raw.githubusercontent.com/Hexxeh/rpi-update/master/rpi-update"
sudo wget https://raw.githubusercontent.com/Hexxeh/rpi-update/master/rpi-update
echo ""
echo "$ sudo mv rpi-update /usr/local/bin/rpi-update"
sudo mv rpi-update /usr/local/bin/rpi-update
echo "$ sudo chmod +x /usr/local/bin/rpi-update"
sudo chmod +x /usr/local/bin/rpi-update
echo ""
echo "$ sudo rpi-update"
sudo rpi-update
echo ""
echo ""
echo ""
echo "==============================================================================="
echo "   • Mise à jour de l'EEPROM"
echo "==============================================================================="
echo ""
echo "$ sudo rpi-eeprom-update -a"
sudo rpi-eeprom-update -a
echo ""
echo ""
echo ""
echo "==============================================================================="
echo "   • Mises à jour de Raspberry Pi OS"
echo "==============================================================================="
echo ""
echo "$ sudo apt-get full-upgrade -y"
sudo apt-get full-upgrade -y
echo ""
echo ""
echo ""
echo "==============================================================================="
echo "   • Préparation de la mise à jour"
echo "==============================================================================="
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
echo "$ sudo rm -rv infosys2.sh"
sudo rm -rv infosys2.sh
echo ""
echo "$ sudo rm -rv test.sh"
sudo rm -rv test.sh
echo ""
if [[ -d "/home/pi/Apps" ]]; then
	echo "$ cd Apps"
	cd ~/Apps
	echo ""
	echo "$ sudo rm -rv install.sh"
	sudo rm -rv install.sh
	echo ""
	echo "$ sudo rm -rv infosys.sh"
	sudo rm -rv infosys.sh
	echo ""
	echo "$ sudo rm -rv infosys2.sh"
	sudo rm -rv infosys2.sh
	echo ""
	echo "$ sudo rm -rv test.sh"
	sudo rm -rv test.sh
	echo ""
	echo "$ sudo rm -rv beta_updater.sh"
	sudo rm -rv beta_updater.sh
	echo ""
	echo "$ sudo rm -rv autoupdate.sh"
	sudo rm -rv autoupdate.sh
	echo ""
	echo "$ sudo rm -rv updater.sh"
	sudo rm -rv updater.sh
	echo ""
fi
echo ""
echo ""
echo "==============================================================================="
echo "   • Installation des logiciels pour Raspberry Pi OS (CLI)"
echo "==============================================================================="
echo ""
echo "$ sudo apt-get install -y ca-certificates git binutils dnsutils debian-goodies iftop curl"
sudo apt-get install -y ca-certificates git binutils dnsutils debian-goodies iftop curl
echo ""
echo "$ curl https://rclone.org/install.sh | sudo bash"
curl https://rclone.org/install.sh | sudo bash
rclone version
echo ""
echo "$ sudo apt-get install -y fail2ban"
sudo apt-get install -y fail2ban
sudo mv /etc/fail2ban/jail.local /etc/fail2ban/jail.local.bak
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/fail2ban/jail.local > jail.local
sudo mv jail.local /etc/fail2ban/jail.local
sudo systemctl enable fail2ban
sudo service fail2ban restart
sudo systemctl --no-pager status fail2ban
echo ""
var20=$(ls /usr/bin/*session)
if [[ $var20 == *"lxsession"* || $var20 == *"openbox"*  || $var20 == *"pipewire-media"* ]]; then
	echo ""
	echo ""
	echo "==============================================================================="
	echo "   • Installation des logiciels pour Raspberry Pi OS (GUI)"
	echo "==============================================================================="
	echo ""
	echo "$ sudo apt-get install -y libreoffice libreoffice-l10n-fr libreoffice-help-fr hyphen-fr libreoffice-style* libreoffice-nlpsolver chromium-browser chromium-browser-l10n filezilla gparted hardinfo baobab stacer hplip cups system-config-printer simple-scan rpi-imager"
	sudo apt-get install -y libreoffice libreoffice-l10n-fr libreoffice-help-fr hyphen-fr libreoffice-style* libreoffice-nlpsolver chromium-browser chromium-browser-l10n filezilla gparted hardinfo baobab stacer hplip cups system-config-printer simple-scan rpi-imager
	echo ""
	echo "$ sudo apt-get install -y anydesk libraspberrypi0 libgles-dev libegl-dev"
	wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
	echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
	sudo apt-get update
	sudo apt-get install -y anydesk libraspberrypi0 libgles-dev libegl-dev
	sudo ln -s /usr/lib/arm-linux-gnueabihf/libGLESv2.so /usr/lib/libbrcmGLESv2.so
	sudo ln -s /usr/lib/arm-linux-gnueabihf/libEGL.so /usr/lib/libbrcmEGL.so	
	echo ""
fi
echo ""
echo ""
if [[ -d "/etc/pihole" ]]; then
	echo "==============================================================================="
	echo "   • Création des dossiers"
	echo "==============================================================================="
	echo ""
	cd
	echo "$ mkdir Apps"
	mkdir Apps
	echo ""
	cd ~/Apps
	echo "$ mkdir log"
	mkdir log
	echo ""
	echo ""
	echo ""
	echo "==============================================================================="
	echo "   • Installation de autoupdate.sh"
	echo "==============================================================================="
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
	echo ""
	echo ""
fi
echo "==============================================================================="
echo "   • Nettoyage et optimisation"
echo "==============================================================================="
echo ""
echo "Avant nettoyage :"
sudo du -h /var/cache/apt/
if [[ -d "/home/pi/.local/share/Trash/" ]]; then
	sudo du -h /home/pi/.local/share/Trash/
fi
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
sudo rm -rv /etc/fail2ban/jail.local
sudo rm -rv /etc/fail2ban/jail.local.bak
echo ""
if [[ -d "/home/pi/Apps" ]]; then
	echo "$ cd ~/Apps"
	cd ~/Apps
	echo ""
	echo "$ sudo rm -rv *_old.sh"
	sudo rm -rv *_old.sh
	echo ""
	if [[ -d "/home/pi/Apps/log" ]]; then
		echo "$ cd ~/Apps/log"
		cd ~/Apps/log
		echo ""
		echo "$ find test*.log -exec rm -rv {} \;"
		find test*.log -exec rm -rv {} \;
		echo ""
		echo "$ find *.log -mtime +31 -exec rm -rv {} \;"
		find *.log -mtime +31 -exec rm -rv {} \;
		echo ""
	fi
fi
if [[ -d "/home/pi/.local/share/Trash/" ]]; then
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
echo "Après nettoyage :"
sudo du -h /var/cache/apt/
if [[ -d "/home/pi/.local/share/Trash/" ]]; then
	sudo du -h /home/pi/.local/share/Trash/
fi
echo ""
echo ""
echo ""
echo "==============================================================================="
echo "   • Validation des mises à jour"
echo "==============================================================================="
echo ""
var100=$(sudo checkrestart)
if [ "$var100" = "Found 0 processes using old versions of upgraded files" ]; then
	echo "$var100"
	echo ""
	echo ""
	echo ""
	echo "###############################################################################"
	echo "#                                                                             #"
	echo "#                Aucun redémarrage du Raspberry Pi nécessaire                 #"
	echo "#                                                                             #"
	echo "###############################################################################"
	echo ""
	sleep 1
else
	echo "$var100"
	echo ""
	echo ""
	echo ""
	echo "###############################################################################"
	echo "#                                                                             #"
	echo "#                         Redémarrage du Raspberry Pi                         #"
	echo "#                                                                             #"
	echo "###############################################################################"
	echo ""
	sleep 1
	sudo reboot
fi
else
echo "Ce programme d'installation n'est compatible qu'avec les Raspberry Pi."
echo "Il ne peut pas être utilisé sur une autre distribution Linux."
echo ""
echo ""
cd
sudo rm install.sh
fi
