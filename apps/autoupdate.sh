#!/bin/bash
cd
echo "autoupdate.sh 2.6.3"
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
echo -n "EEPROM          : "
sudo rpi-eeprom-update
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
echo "   Mise à jour du module autoupdate_conf.sh"
echo "-------------------------------------------------------------------------------"
echo ""
echo "wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/autoupdate_conf.sh > autoupdate_conf_new.sh"
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/autoupdate_conf.sh > autoupdate_conf_new.sh
echo ""
echo "sudo mv autoupdate_conf.sh autoupdate_conf_old.sh"
sudo mv autoupdate_conf.sh autoupdate_conf_old.sh
echo "sudo mv autoupdate_conf_new.sh autoupdate_conf.sh"
sudo mv autoupdate_conf_new.sh autoupdate_conf.sh
echo "sudo chmod +x autoupdate_conf.sh"
sudo chmod +x autoupdate_conf.sh
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "   Execution du module autoupdate_conf.sh"
echo "-------------------------------------------------------------------------------"
echo ""
./autoupdate_conf.sh
