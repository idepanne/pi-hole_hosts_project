#!/bin/bash
cd
echo "autoupdate.sh 2.4.8.1"
echo "© 2020 iDépanne – L'expert informatique"
echo ""
cat /proc/cpuinfo | grep Model
cat /proc/cpuinfo | grep Serial
echo -n "OS              : "; uname -sr
echo ""
df -h | grep /var/log
df -h | grep /dev/root
echo ""
echo ""
echo "*** Vérification des prérequis ***"
echo ""
sudo apt-get install -y dnsutils
sudo apt-get install -y debian-goodies
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
