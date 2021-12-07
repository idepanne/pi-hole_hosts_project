#!/bin/bash
clear
cd
echo "###############################################################################"
echo "#                                                                             #"
echo "#                     Pi-Hole Host Project Updater 8.0.0b2                    #"
echo "#                 © 2020-2021 iDépanne – L'expert informatique                #"
echo "#                           https://fb.me/idepanne/                           #"
echo "#                            idepanne67@gmail.com                             #"
echo "#                                                                             #"
echo "###############################################################################"
echo ""
echo ""
echo ""


###### Définition des variables ######
var1=$(cat /proc/cpuinfo | grep Hardware | cut -c12-)
if [[ $var1 == *"BCM"* ]]; then
	var2="Broadcom"
fi
var3=$(cat /proc/cpuinfo | grep Revision | cut -c12-)
var4=$(lscpu | grep "Model name:" | cut -c34-)
var5=$(lscpu | grep "Vendor ID:" | cut -c34-)
var6=$(lscpu | grep "CPU(s):" | cut -c34-)
var7=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq | rev | cut -c4- | rev)
var8=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq | rev | cut -c4- | rev)
var9=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq | rev | cut -c4- | rev)
var10=$(vcgencmd measure_volts core | cut -c6-)
var11=$(vcgencmd get_config int | egrep "(gpu_freq)" | cut -c10-)
var12=$(echo $var11 | rev | cut -c9- | rev)
var13=$(uname -srv)
var14=$(cat /etc/os-release | grep PRETTY_NAME | cut -c14-)
var15=$(echo $var14 | rev | cut -c3- | rev)
var16=$(uname -m)
if [[ $var16 == *"aarch64"* ]]; then
	var17="- 64 bits)"
else
	var17="- 32 bits)"
fi
var18=$(uptime -s)
var19=$(uptime -p)
var20=$(ls /usr/bin/*session)
######################################


echo "==============================================================================="
echo "   • A propos de ce Raspberry Pi"
echo "==============================================================================="
echo ""
cat /proc/cpuinfo | grep Model
echo ""
cat /proc/cpuinfo | grep Serial
echo ""
echo -n "SoC             : " && echo "$var2 $var1 (Rev $var3)"
echo -n "Processeur      : " && echo "$var5 $var4"
echo -n "Nb de coeurs    : " && echo "$var6"
echo -n "Fréquences      : "; echo "Min $var7 MHz - Cur $var8 MHz - Max $var9 MHz"
echo -n "Voltage         : "; echo "$var10"
echo -n "Température     : "; echo "$(vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*')°C"
echo ""
echo -n "GPU RAM         : " && echo "$(vcgencmd get_mem gpu)" | cut -c5-
echo -n "GPU fréquences  : "; echo "$var12 MHz"
echo -n "Codec H264      : " && echo "$(vcgencmd codec_enabled H264)" | cut -c6-
echo -n "Codec H265      : " && echo "$(vcgencmd codec_enabled H265)" | cut -c6-
echo ""
echo -n "Système         : "; echo "$var15 $var17"
if [[ $var20 == *"lxsession"* || $var1 == *"openbox"*  || $var1 == *"pipewire-media"* ]]; then
echo "Interface       : Graphique (GUI)"
else
echo "Interface       : Lignes de commandes (CLI)"
fi
echo ""
echo -n "Firmware        : "; echo "$var13"
echo ""
echo -n "EEPROM          : "
sudo rpi-eeprom-update
echo ""
echo -n "IPv4/IPv6       : "; hostname -I
echo ""
echo -n "Nom d'hôte      : "; hostname
echo ""
echo -n "Démarré depuis  : " && echo "$var18 - $var19"
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
echo "   • Vérification des connexions SSH actives"
echo "==============================================================================="
echo ""
netstat -tn 2>/dev/null | grep :22 | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head
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
echo "$ sudo apt-get update --fix-missing"
sudo apt-get update --fix-missing
echo ""
echo "$ sudo apt-get full-upgrade -y"
sudo apt-get full-upgrade -y
echo ""
echo ""
echo ""
echo "==============================================================================="
echo "   • Nettoyage"
echo "==============================================================================="
echo ""
echo "cd"
cd
echo ""
echo "$ sudo rm -rv install.sh"
sudo rm -rv install.sh
echo ""
echo "$ sudo rm -rv infosys.sh"
sudo rm -rv infosys.sh
echo ""
echo "$ sudo rm -rv test.sh"
sudo rm -rv test.sh
echo ""
echo "cd ~/Apps"
cd ~/Apps
echo ""
echo "$ sudo rm -rv install.sh"
sudo rm -rv install.sh
echo ""
echo "$ sudo rm -rv infosys.sh"
sudo rm -rv infosys.sh
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
echo ""
echo ""
echo "==============================================================================="
echo "   • Installation des logiciels prérequis pour Raspberry Pi OS (CLI)"
echo "==============================================================================="
echo ""
echo "$ sudo apt-get install -yf ca-certificates git binutils"
sudo apt-get install -yf ca-certificates git binutils
echo ""
echo "$ sudo apt-get install -yf dnsutils"
sudo apt-get install -yf dnsutils
echo ""
echo "$ sudo apt-get install -yf debian-goodies"
sudo apt-get install -yf debian-goodies
echo ""
echo "$ sudo apt-get install -yf iftop"
sudo apt-get install -yf iftop
echo ""
echo "$ sudo apt-get install -yf rclone"
sudo apt-get install -yf rclone
echo ""
echo "$ sudo apt-get install -yf speedtest-cli"
sudo apt-get install -yf speedtest-cli
echo ""
if [[ $var20 == *"lxsession"* || $var1 == *"openbox"*  || $var1 == *"pipewire-media"* ]]; then
	echo ""
	echo ""
	echo "==============================================================================="
	echo "   • Installation des logiciels prérequis pour Raspberry Pi OS (GUI)"
	echo "==============================================================================="
	echo ""
	echo "$ sudo apt-get install -yf libreoffice libreoffice-l10n-fr libreoffice-help-fr hyphen-fr libreoffice-style* libreoffice-nlpsolver"
	sudo apt-get install -yf libreoffice libreoffice-l10n-fr libreoffice-help-fr hyphen-fr libreoffice-style* libreoffice-nlpsolver
	echo ""
	echo "$ sudo apt-get install -yf chromium-browser chromium-browser-l10n"
	sudo apt-get install -yf chromium-browser chromium-browser-l10n
	echo ""
	echo "$ sudo apt-get install -yf filezilla"
	sudo apt-get install -yf filezilla
	echo ""
	echo "$ sudo apt-get install -yf gparted"
	sudo apt-get install -yf gparted
	echo ""
	echo "$ sudo apt-get install -yf hardinfo"
	sudo apt-get install -yf hardinfo
	echo ""
	echo "$ sudo apt-get install -yf baobab"
	sudo apt-get install -yf baobab
	echo ""
	echo "$ sudo apt-get install -yf rpi-imager"
	sudo apt-get install -yf rpi-imager
	echo ""
fi
echo ""
echo ""
echo "==============================================================================="
echo "   • Test de débit Internet"
echo "==============================================================================="
echo ""
echo "-> Pour que les résultats soient cohérents, aucun autre appareil du réseau ne doit télécharger des données pendant le test."
echo ""
speedtest-cli
echo ""
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
echo ""
echo ""
echo ""
echo "###############################################################################"
echo "#                                                                             #"
echo "#                         Redémarrage du Raspberry Pi                         #"
echo "#                                                                             #"
echo "###############################################################################"
sleep 1
sudo reboot