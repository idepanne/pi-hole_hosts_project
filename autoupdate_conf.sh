#!/bin/bash
cd
echo "autoupdate_conf.sh 2.4.5"
echo "© 2020 iDépanne – L'expert informatique"
echo ""
echo ""
echo "*** Mise à jour d'autoupdate.sh ***"
echo ""
echo "wget -O - -q -t 1 https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/autoupdate.sh > autoupdate_new.sh"
wget -O - -q -t 1 https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/autoupdate.sh > autoupdate_new.sh
echo ""
echo "sudo mv autoupdate.sh autoupdate_old.sh"
sudo mv autoupdate.sh autoupdate_old.sh
echo "sudo mv autoupdate_new.sh autoupdate.sh"
sudo mv autoupdate_new.sh autoupdate.sh
echo "sudo chmod +x autoupdate.sh"
sudo chmod +x autoupdate.sh
echo ""
echo ""
echo "*** Mises à jour du système ***"
echo ""
echo "$ sudo apt-get update"
sudo apt-get update
echo ""
echo "$ sudo apt-get upgrade -y"
sudo apt-get upgrade -y
echo ""
echo "$ sudo apt-get dist-upgrade -y"
sudo apt-get dist-upgrade -y
echo ""
echo "$ sudo pihole -up"
sudo pihole -up
echo ""
echo "$ sudo pihole -g"
sudo pihole -g
echo ""
echo "*** Mises à jour terminée ***"
echo ""
echo ""
echo "*** Nettoyage du système ***"
echo ""
echo "$ sudo apt-get autoremove -y"
sudo apt-get autoremove -y
echo ""
echo "$ sudo apt-get autoclean -y"
sudo apt-get autoclean -y
echo ""
echo "$ sudo apt-get clean -y"
sudo apt-get clean -y
echo ""
echo "sudo rm -rv autoupdate_old.sh"
sudo rm -rv autoupdate_old.sh
echo ""
echo "sudo rm -rv autoupdate_conf_old.sh"
sudo rm -rv autoupdate_conf_old.sh
echo ""
echo "find /home/pi/logs/* -mtime +30 -exec rm -rv {} \;"
find /home/pi/logs/* -mtime +30 -exec rm -rv {} \;
echo ""
echo "*** Nettoyage terminé ***"
echo ""
var=$(sudo checkrestart)
if [ "$var" = "Found 0 processes using old versions of upgraded files" ]; then
        echo "$var"
        echo ""
        echo "*** Aucun redémarrage nécessaire ***"
else
        echo "$var"
        echo ""
        echo "*** Redémarrage du Raspberry Pi ***"
        sleep 1
        sudo reboot
fi
