#!/bin/bash
clear
cd
echo "install.sh 4.1.2"
echo "© 2020-2021 iDépanne – L'expert informatique"
echo "https://fb.me/idepanne/"
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "   Mise à jour du module infos_system.sh"
echo "-------------------------------------------------------------------------------"
echo ""
echo "wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/infos_system.sh > infos_system.sh"
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/infos_system.sh > infos_system.sh
echo ""
echo "sudo chmod +x infos_system.sh"
sudo chmod +x infos_system.sh
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "   Mise à jour du module install2.sh"
echo "-------------------------------------------------------------------------------"
echo ""
echo "wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/install2.sh > install2.sh"
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/install2.sh > install2.sh
echo ""
echo "sudo chmod +x install2.sh"
sudo chmod +x install2.sh
echo ""
./infos_system.sh
