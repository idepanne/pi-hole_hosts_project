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
#var11=$(lscpu | grep "Architecture:" | cut -c22-)
var11=$(uname -m)
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
echo -n "Codec H265      : " && echo "$(vcgencmd codec_enabled H265)" | cut -c6-
echo ""
echo -n "Firmware        : "
uname -rv
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
echo "==============================================================================="
cd
sudo rm infosys.sh