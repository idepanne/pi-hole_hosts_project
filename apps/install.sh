#!/bin/bash
clear
cd
echo "###############################################################################"
echo "#                                                                             #"
echo "#                      Pi-Hole Host Project Updater 7.0.0                     #"
echo "#                 © 2020-2021 iDépanne – L'expert informatique                #"
echo "#                           https://fb.me/idepanne/                           #"
echo "#                            idepanne67@gmail.com                             #"
echo "#                                                                             #"
echo "###############################################################################"
echo ""
echo ""
echo ""
###### Définition des variables ######
var0=$(cat /proc/cpuinfo | grep Hardware | cut -c12-)
if [[ $var0 == *"BCM"* ]]; then
	var1="Broadcom"
fi
var2=$(lscpu | grep "Model name:" | cut -c22-)
var3=$(lscpu | grep "Vendor ID:" | cut -c22-)
var4=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq | rev | cut -c4- | rev)
var5=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq | rev | cut -c4- | rev)
var6=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq | rev | cut -c4- | rev)
var7=$(vcgencmd measure_volts core | cut -c6-)
var8=$(vcgencmd get_config int | egrep "(gpu_freq)" | cut -c10-)
var9=$(echo $var8 | rev | cut -c9- | rev)
var10=$(uname -sr)
var11=$(lscpu | grep "Architecture:" | cut -c22-)
if [[ $var11 == *"aarch64"* ]]; then
	var12="(64 bits)"
else
	var12="(32 bits)"
fi
var13=$(uptime -s)
var14=$(uptime -p)
######################################
echo "==============================================================================="
echo "   • A propos de ce Raspberry Pi"
echo "==============================================================================="
echo ""
cat /proc/cpuinfo | grep Model
echo ""
cat /proc/cpuinfo | grep Serial
echo ""
echo -n "SoC             : " && echo "$var1 $var0"
echo -n "Processeur      : " && echo "$var3 $var2"
echo -n "Fréquences      : "; echo "Min $var4 MHz - Cur $var5 MHz - Max $var6 MHz"
echo -n "Voltage         : "; echo "$var7"
echo -n "Température     : "; echo "$(vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*')°C"
echo ""
echo -n "GPU RAM         : " && echo "$(vcgencmd get_mem gpu)" | cut -c5-
echo -n "GPU fréquences  : "; echo "$var9 MHz"
echo -n "Codec H264      : " && echo "$(vcgencmd codec_enabled H264)" | cut -c6-
echo ""
echo -n "Firmware        : "
/opt/vc/bin/vcgencmd version
echo ""
echo -n "EEPROM          : "
sudo rpi-eeprom-update
echo ""
echo -n "Système         : "; echo "$var10 $var12"
echo ""
echo -n "IPv4/IPv6       : "; hostname -I
echo ""
echo -n "Nom d'hôte      : "; hostname
echo ""
echo -n "Démarré depuis  : " && echo "$var13 - $var14"
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
if [[ -d "/etc/boinc-client" ]]; then
	var=$(hostname)
	echo "==============================================================================="
	echo "   • Arrêt du node \"$var\" dans le cluster BOINC"
	echo "==============================================================================="
	echo ""
	echo "$ sudo systemctl stop boinc-client"
	sudo systemctl stop boinc-client
	sleep 1
	echo ""
	echo ""
	echo ""
fi
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
echo "   • Création des dossiers"
echo "==============================================================================="
echo ""
cd
echo "$ mkdir Apps"
mkdir Apps
echo ""

#################### A supprimer ####################
cd
if [[ -d "/home/pi/log" ]]; then
	echo "sudo mv /home/pi/log /home/pi/Apps/log"
	sudo mv /home/pi/log /home/pi/Apps/log
	echo ""
	cd ~/Apps
else
#####################################################

cd ~/Apps
echo "$ mkdir log"
mkdir log

#################### A supprimer ####################
fi
#####################################################

echo ""
echo ""
echo ""
echo "==============================================================================="
echo "   • Mises à jour de Raspberry Pi OS"
echo "==============================================================================="
echo ""
echo "$ sudo apt-get clean all"
sudo apt-get clean all
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
echo ""
echo ""
echo "==============================================================================="
echo "   • Installation des logiciels prérequis"
echo "==============================================================================="
echo ""
cd
echo "$ sudo rm -rv install.sh"
sudo rm -rv install.sh
echo ""

#################### A supprimer ####################
echo "$ sudo rm -rv beta"
sudo rm -rv beta
echo ""
echo "$ sudo rm -rv beta_updater.sh"
sudo rm -rv beta_updater.sh
echo ""
echo "$ sudo rm -rv autoupdate.sh"
sudo rm -rv autoupdate.sh
echo ""
echo "$ sudo rm -rv infosys.sh"
sudo rm -rv infosys.sh
echo ""
echo "$ sudo rm -rv jail.local"
sudo rm -rv jail.local
echo ""
echo "$ sudo rm -rv updater.sh"
sudo rm -rv updater.sh
echo ""
echo "$ sudo rm -rv test.sh"
sudo rm -rv test.sh
echo ""
#####################################################

cd ~/Apps
echo "$ sudo rm -rv beta_updater.sh"
sudo rm -rv beta_updater.sh
echo ""
echo "$ sudo rm -rv autoupdate.sh"
sudo rm -rv autoupdate.sh
echo ""
echo "$ sudo rm -rv infosys.sh"
sudo rm -rv infosys.sh
echo ""
echo "$ sudo rm -rv jail.local"
sudo rm -rv jail.local
echo ""
echo "$ sudo rm -rv updater.sh"
sudo rm -rv updater.sh
echo ""
echo "$ sudo rm -rv test.sh"
sudo rm -rv test.sh
echo ""
echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate.sh > autoupdate.sh"
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate.sh > autoupdate.sh
echo ""
echo "$ sudo chmod +x autoupdate.sh"
sudo chmod +x autoupdate.sh
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
echo "$ sudo apt-get install -yf ca-certificates git binutils"
sudo apt-get install -yf ca-certificates git binutils
echo ""
echo "$ sudo apt-get install -yf fail2ban"
sudo apt-get install -yf fail2ban
echo ""
echo "$ sudo rm -rv /etc/fail2ban/jail.local"
sudo rm -rv /etc/fail2ban/jail.local
echo ""
echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/jail.local > jail.local"
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/jail.local > jail.local
echo ""
echo "$ sudo mv jail.local /etc/fail2ban/jail.local"
sudo mv jail.local /etc/fail2ban/jail.local
echo ""
echo "$ sudo service fail2ban restart"
sudo service fail2ban restart
echo ""
echo "$ sudo systemctl --no-pager status fail2ban"
sudo systemctl --no-pager status fail2ban
echo ""
var1=$(cat /proc/cpuinfo | grep Model)
if [[ $var1 == *"Pi 400"* ]]; then
	echo ""
	echo ""
	echo "==============================================================================="
	echo "   • Installation des logiciels prérequis pour le Raspberry Pi 400"
	echo "==============================================================================="
	echo ""
	echo "$ sudo apt-get install -yf libreoffice libreoffice-l10n-fr libreoffice-help-fr hyphen-fr libreoffice-style*"
	sudo apt-get install -yf libreoffice libreoffice-l10n-fr libreoffice-help-fr hyphen-fr libreoffice-style*
	echo ""
	echo "$ sudo apt-get install -yf gparted"
	sudo apt-get install -yf gparted
	echo ""
	echo "$ sudo apt-get install -yf hardinfo"
	sudo apt-get install -yf hardinfo
	echo ""
	echo "$ sudo apt-get install -yf filezilla"
	sudo apt-get install -yf filezilla
	echo ""
fi
echo ""
echo ""
echo "==============================================================================="
echo "   • Mise à jour du crontab"
echo "==============================================================================="
echo ""
echo "Ancien crontab :"
crontab -l
echo ""
var1=$(cat /proc/cpuinfo | grep Model)
if [[ $var1 == *"Pi 400"* ]]; then
	crontab <<<"30 7 * * * /home/pi/Apps/autoupdate.sh > /home/pi/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
0 8 * * * /home/pi/Apps/backup.sh"
else
if [[ -f "/home/pi/Apps/backup.sh" ]]; then
	crontab <<<"0 3 * * * /home/pi/Apps/autoupdate.sh > /home/pi/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
30 3 * * * /home/pi/Apps/backup.sh"
else
	crontab <<<"0 3 * * * /home/pi/Apps/autoupdate.sh > /home/pi/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1"
fi
fi
sudo /etc/init.d/cron restart
echo ""
echo "Nouveau crontab :"
crontab -l
echo ""
echo ""
echo ""
echo "==============================================================================="
echo "   • Nettoyage et optimisation"
echo "==============================================================================="
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
cd ~/Apps
echo "$ sudo rm -rv *_old.sh"
sudo rm -rv *_old.sh
echo ""
echo "$ cd ~/Apps/log && find test*.log -exec rm -rv {} \;"
cd ~/Apps/log && find test*.log -exec rm -rv {} \;
echo ""
echo "$ cd ~/Apps/log && find *.log -mtime +31 -exec rm -rv {} \;"
cd ~/Apps/log && find *.log -mtime +31 -exec rm -rv {} \;
cd ~/Apps
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