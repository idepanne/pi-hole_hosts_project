#!/bin/bash
clear
cd
echo "install.sh 2.0.0b1"
echo "© 2020 iDépanne – L'expert informatique"
echo "https://idepanne.now.site"
echo ""
echo ""
echo "wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/infos_system.sh > infos_system.sh"
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/infos_system.sh > infos_system.sh
echo ""
echo "sudo chmod +x infos_system.sh"
sudo chmod +x infos_system.sh
echo ""
echo ""
./infos_system.sh
