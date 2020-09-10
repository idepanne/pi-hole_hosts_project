#!/bin/bash

# autoupdate_conf.sh 3.0.0b4
# © 2020 iDépanne – L'expert informatique
# https://idepanne.now.site

echo "sudo rm -rv *_old.sh"
sudo rm -rv *_old.sh
echo ""
echo "sudo rm -rv *_new.sh"
sudo rm -rv *_new.sh
echo ""
echo "sudo rm -rv install*"
sudo rm -rv install*
echo ""
echo "sudo rm -rv install*"
sudo rm -rv install*
echo ""
echo "-------------------------------------------------------------------------------"
echo "   Mise à jour du module autoupdate.sh"
echo "-------------------------------------------------------------------------------"
echo ""
echo "wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate.sh > autoupdate_new.sh"
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate.sh > autoupdate_new.sh
echo ""
echo "sudo mv autoupdate.sh autoupdate_old.sh"
sudo mv autoupdate.sh autoupdate_old.sh
echo "sudo mv autoupdate_new.sh autoupdate.sh"
sudo mv autoupdate_new.sh autoupdate.sh
echo "sudo chmod +x autoupdate.sh"
sudo chmod +x autoupdate.sh
echo ""
./autoupdate.sh
