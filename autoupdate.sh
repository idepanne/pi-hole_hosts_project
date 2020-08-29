#!/bin/bash
cd
echo "autoupdate.sh 2.4.0b4"
echo "© 2020 iDépanne – L'expert informatique"
echo ""
cat /proc/cpuinfo | grep Model
cat /proc/cpuinfo | grep Serial
uname -sr
echo ""
echo ""
echo "*** Mise à jour d'autoupdate_conf.sh ***"
echo ""
echo "sudo curl https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/autoupdate_conf.sh > autoupdate_conf_new.sh"
sudo curl https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/autoupdate_conf.sh > autoupdate_conf_new.sh
echo ""
echo "sudo mv autoupdate_conf.sh autoupdate_conf_old.sh"
sudo mv autoupdate_conf.sh autoupdate_conf_old.sh
echo "sudo mv autoupdate_conf_new.sh autoupdate_conf.sh"
sudo mv autoupdate_conf_new.sh autoupdate_conf.sh
echo "sudo chmod +x autoupdate_conf.sh"
sudo chmod +x autoupdate_conf.sh
echo "sudo rm -rv autoupdate_conf_old.sh"
sudo rm -rv autoupdate_conf_old.sh
echo ""
echo "*** Execution de autoupdate_conf.sh ***"
echo "./autoupdate_conf.sh
