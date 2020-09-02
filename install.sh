#!/bin/bash
clear
cd
echo "install.sh 1.0.0b5"
echo "© 2020 iDépanne – L'expert informatique"
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "   Informations système"
echo "-------------------------------------------------------------------------------"
echo ""
cat /proc/cpuinfo | grep Model
cat /proc/cpuinfo | grep Serial
echo ""
var1=$(lscpu | grep "Model name:" | sed -r 's/Model name:\s{1,}//g')
var2=$(lscpu | grep "Vendor ID:" | sed -r 's/Vendor ID:\s{1,}//g')
echo -n "Processeur      : " && echo "$var2 $var1"
cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))
echo -n "Température     : "; echo CPU temp"="$cpuTemp1"."$cpuTempM"'C"
echo -n "                  "; echo GPU $(/opt/vc/bin/vcgencmd measure_temp)
echo ""
echo -n "Firmware        : "
/opt/vc/bin/vcgencmd version
echo ""
echo -n "Système         : "; uname -sr
echo -n "IPv4/IPv6       : "; hostname -I
echo ""
echo "Stockage        : "
df -h /
df -h | grep /var/log
echo ""
echo "RAM             : "
free -ht
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "   Installation des prérequis"
echo "-------------------------------------------------------------------------------"
echo ""
echo "sudo apt-get install -yf dnsutils"
sudo apt-get install -yf dnsutils
echo ""
echo "sudo apt-get install -yf debian-goodies"
sudo apt-get install -yf debian-goodies
echo ""
echo "sudo apt-get install -y ca-certificates git binutils"
sudo apt-get install -y ca-certificates git binutils
echo ""
echo "sudo wget https://raw.githubusercontent.com/Hexxeh/rpi-update/master/rpi-update"
sudo wget https://raw.githubusercontent.com/Hexxeh/rpi-update/master/rpi-update
echo ""
echo "sudo mv rpi-update /usr/local/bin/rpi-update"
sudo mv rpi-update /usr/local/bin/rpi-update
echo "sudo chmod +x /usr/local/bin/rpi-update"
sudo chmod +x /usr/local/bin/rpi-update
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "   Mise à jour du firmware du Raspberry Pi"
echo "-------------------------------------------------------------------------------"
echo ""
echo "sudo rpi-update"
sudo rpi-update
echo ""
echo "/opt/vc/bin/vcgencmd version"
/opt/vc/bin/vcgencmd version
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "   Installation du module autoupdate.sh"
echo "-------------------------------------------------------------------------------"
echo ""
echo "wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/autoupdate.sh > autoupdate.sh"
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/autoupdate.sh > autoupdate.sh
echo ""
echo "sudo chmod +x autoupdate.sh"
sudo chmod +x autoupdate.sh
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "   Installation du module autoupdate_conf.sh"
echo "-------------------------------------------------------------------------------"
echo ""
echo "wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/autoupdate_conf.sh > autoupdate_conf.sh"
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/autoupdate_conf.sh > autoupdate_conf.sh
echo ""
echo "sudo chmod +x autoupdate_conf.sh"
sudo chmod +x autoupdate_conf.sh
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "   Création du dossier logs"
echo "-------------------------------------------------------------------------------"
echo ""
echo "mkdir logs"
mkdir logs
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "   Execution du module autoupdate_conf.sh"
echo "-------------------------------------------------------------------------------"
echo ""
./autoupdate_conf.sh
