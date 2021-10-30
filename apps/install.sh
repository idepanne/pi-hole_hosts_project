#!/bin/bash
clear
cd
echo "###############################################################################"
echo "#                                                                             #"
echo "#                      Pi-Hole Host Project Updater 6.3.0                     #"
echo "#                 © 2020-2021 iDépanne – L'expert informatique                #"
echo "#                           https://fb.me/idepanne/                           #"
echo "#                            idepanne67@gmail.com                             #"
echo "#                                                                             #"
echo "###############################################################################"
echo ""
echo ""
echo ""
echo "==============================================================================="
echo "   • A propos de ce Raspberry Pi"
echo "==============================================================================="
echo ""
cat /proc/cpuinfo | grep Model
echo ""
cat /proc/cpuinfo | grep Serial
echo ""
var1=$(lscpu | grep "Model name:" | sed -r 's/Model name:\s{1,}//g')
var2=$(lscpu | grep "Vendor ID:" | sed -r 's/Vendor ID:\s{1,}//g')
echo -n "Processeur      : " && echo "$var2 $var1"
echo -n "Fréquence       : " && echo "$(sudo cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq)"
echo ""
cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))
echo -n "Température     : "; echo CPU "= "$cpuTemp1"."$cpuTempM"°C"
echo -n "                  "; echo "GPU = $(vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*')°C"
echo ""
echo -n "Firmware        : "
/opt/vc/bin/vcgencmd version
echo ""
echo -n "EEPROM          : "
sudo rpi-eeprom-update
echo ""
echo -n "Système         : "; uname -sr
echo ""
echo -n "IPv4/IPv6       : "; hostname -I
echo ""
echo -n "Nom d'hôte      : "; hostname
echo ""
var3=$(uptime -s)
var4=$(uptime -p)
echo -n "Démarré depuis  : " && echo "$var3 - $var4"
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