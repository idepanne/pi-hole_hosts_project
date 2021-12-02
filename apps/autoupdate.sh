#!/bin/bash
echo "###############################################################################"
echo "#                                                                             #"
echo "#                     Pi-Hole Host Project Updater 7.0.5b2                    #"
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
cd ~/Apps
echo "==============================================================================="
echo "   • Vérification des connexions SSH actives"
echo "==============================================================================="
echo ""
netstat -tn 2>/dev/null | grep :22 | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head
echo ""
echo ""
echo ""
echo "==============================================================================="
echo "   • Test de la connexion Internet"
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
	if [[ -f "/home/pi/Apps/beta" ]]; then
		echo "==============================================================================="
		echo "   • Canal de mises à jour : Beta"
		echo "==============================================================================="
		echo ""
		echo "$ sudo mv updater.sh updater_old.sh"
		sudo mv updater.sh updater_old.sh
		echo ""
		echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/beta_updater.sh > updater.sh"
		wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/beta_updater.sh > updater.sh
		echo ""
		echo "$ sudo chmod +x updater.sh"
		sudo chmod +x updater.sh
	else
		echo "==============================================================================="
		echo "   • Canal de mises à jour : Release"
		echo "==============================================================================="
		echo ""
		echo "$ sudo mv updater.sh updater_old.sh"
		sudo mv updater.sh updater_old.sh
		echo ""
		echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/updater.sh > updater.sh"
		wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/updater.sh > updater.sh
		echo ""
		echo "$ sudo chmod +x updater.sh"
		sudo chmod +x updater.sh
	fi
	if [[ -d "/etc/pihole" ]]; then
		echo ""
		echo ""
		echo ""
		echo "==============================================================================="
		echo "   • Test de débit Internet"
		echo "==============================================================================="
		echo ""
		echo "/!\ Pour que le résultat soit proche du débit réellement disponible, aucun
autre appareil du réseau ne doit télécharger des données au moment du test. /!\"
		echo ""
		speedtest-cli
		echo ""
	fi
	./updater.sh
else
	echo "Connexion Internet : Echec"
	echo ""
	echo ""
	echo "*** Abandon des mises à jour | Nouvelle tentative dans 24h ***"
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
var20=$(ls /usr/bin/*session)
if [[ $var20 == *"lxsession"* || $var1 == *"openbox"*  || $var1 == *"pipewire-media"* ]]; then
	crontab <<<"0 8 * * * /home/pi/Apps/autoupdate.sh > /home/pi/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
30 8 * * * /home/pi/Apps/backup.sh"
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
fi