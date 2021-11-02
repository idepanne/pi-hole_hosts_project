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
var1=$(cat /proc/cpuinfo | grep Hardware | cut -c12-)
if [[ $var1 == *"BCM"* ]]; then
	var2="Broadcom"
fi
var3=$(cat /proc/cpuinfo | grep Revision | cut -c12-)
var4=$(lscpu | grep "Model name:" | cut -c22-)
var5=$(lscpu | grep "Vendor ID:" | cut -c22-)
var6=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq | rev | cut -c4- | rev)
var7=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq | rev | cut -c4- | rev)
var8=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq | rev | cut -c4- | rev)
var9=$(vcgencmd measure_volts core | cut -c6-)
var10=$(vcgencmd get_config int | egrep "(gpu_freq)" | cut -c10-)
var11=$(echo $var10 | rev | cut -c9- | rev)
var12=$(uname -sr)
var13=$(uname -m)
if [[ $var13 == *"aarch64"* ]]; then
	var14="(64 bits)"
else
	var14="(32 bits)"
fi
var15=$(uptime -s)
var16=$(uptime -p)
######################################
echo "==============================================================================="
echo "   • A propos de ce Raspberry Pi"
echo "==============================================================================="
echo ""
cat /proc/cpuinfo | grep Model
echo ""
cat /proc/cpuinfo | grep Serial
echo ""
echo -n "SoC             : " && echo "$var2 $var1 (Rev. $var3)"
echo -n "Processeur      : " && echo "$var5 $var4"
echo -n "Fréquences      : "; echo "Min $var6 MHz - Cur $var7 MHz - Max $var8 MHz"
echo -n "Voltage         : "; echo "$var9"
echo -n "Température     : "; echo "$(vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*')°C"
echo ""
echo -n "GPU RAM         : " && echo "$(vcgencmd get_mem gpu)" | cut -c5-
echo -n "GPU fréquences  : "; echo "$var11 MHz"
echo -n "Codec H264      : " && echo "$(vcgencmd codec_enabled H264)" | cut -c6-
echo -n "Codec H265      : " && echo "$(vcgencmd codec_enabled H265)" | cut -c6-
echo ""
echo -n "Système         : "; echo "$var12 $var14"
echo ""
echo -n "Firmware        : "
uname -v
echo ""
echo -n "EEPROM          : "
sudo rpi-eeprom-update
echo ""
echo -n "IPv4/IPv6       : "; hostname -I
echo ""
echo -n "Nom d'hôte      : "; hostname
echo ""
echo -n "Démarré depuis  : " && echo "$var15 - $var16"
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
echo "==============================================================================="
cd
sudo rm infosys.sh