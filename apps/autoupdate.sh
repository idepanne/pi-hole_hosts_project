#!/bin/bash
cd
echo "autoupdate.sh 3.0.0"
echo "© 2020 iDépanne – L'expert informatique"
echo "https://idepanne.now.site"
echo ""
echo ""
echo "wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/infos_system.sh > infos_system_new.sh"
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/infos_system.sh > infos_system_new.sh
echo ""
echo "sudo mv infos_system.sh infos_system_old.sh"
sudo mv infos_system.sh infos_system_old.sh
echo "sudo mv infos_system_new.sh infos_system.sh"
sudo mv infos_system_new.sh infos_system.sh
echo "sudo chmod +x infos_system.sh"
sudo chmod +x infos_system.sh
echo ""
echo ""
echo "wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate_conf.sh > autoupdate_conf_new.sh"
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate_conf.sh > autoupdate_conf_new.sh
echo ""
echo "sudo mv autoupdate_conf.sh autoupdate_conf_old.sh"
sudo mv autoupdate_conf.sh autoupdate_conf_old.sh
echo "sudo mv autoupdate_conf_new.sh autoupdate_conf.sh"
sudo mv autoupdate_conf_new.sh autoupdate_conf.sh
echo "sudo chmod +x autoupdate_conf.sh"
sudo chmod +x autoupdate_conf.sh
echo ""
./infos_system.sh
