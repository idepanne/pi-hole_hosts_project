#!/bin/bash
clear
cd
echo "autoupdate.sh 2.6.1"
echo "© 2020 iDépanne – L'expert informatique"
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "   Execution du module verifconfig.sh"
echo "-------------------------------------------------------------------------------"
echo ""
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/verifconfig.sh > verifconfig.sh
sudo chmod +x verifconfig.sh
./verifconfig.sh
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
