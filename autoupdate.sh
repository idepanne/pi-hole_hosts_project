#!/bin/bash
cd
echo "autoupdate.sh 2.5.0"
echo "© 2020 iDépanne – L'expert informatique"
echo ""
echo ""
echo "*** Informations système ***"
echo ""
cat /proc/cpuinfo | grep Model
cat /proc/cpuinfo | grep Serial
echo ""
echo -n "Processeur      : "; lscpu | grep "Model name:" | sed -r 's/Model name:\s{1,}//g'
cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))
echo -n "Température     : "; echo CPU temp"="$cpuTemp1"."$cpuTempM"'C"
echo -n "                  "; echo GPU $(/opt/vc/bin/vcgencmd measure_temp)
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
echo "*** Vérification des prérequis ***"
echo ""
sudo apt-get install -yf dnsutils
sudo apt-get install -yf debian-goodies
echo ""
echo "*** Vérification terminée ***"
echo ""
echo ""
echo "*** Mise à jour du module autoupdate_conf.sh ***"
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
echo "*** Execution du module autoupdate_conf.sh ***"
echo ""
echo ""
echo "------------------------------------------------------------------------------"
echo ""
echo ""
./autoupdate_conf.sh
