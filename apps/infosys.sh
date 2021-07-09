#!/bin/bash
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
cd
echo "$ sudo rm -rv infosys.sh"
sudo rm -rv infosys.sh