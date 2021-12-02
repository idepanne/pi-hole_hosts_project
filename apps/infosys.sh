#!/bin/bash
clear
cd
echo "###############################################################################"
echo "#                                                                             #"
echo "#                     Pi-Hole Host Project Updater 7.0.5b3                    #"
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
echo "   • Test de débit Internet"
echo "==============================================================================="
echo ""
echo "-> Pour que les résultats soient cohérent, aucun autre appareil du réseau ne doit télécharger des données pendant le test !"
echo ""
speedtest-cli
echo ""
echo "==============================================================================="
cd
sudo rm infosys.sh