#!/bin/bash
cd
echo "autoupdate_conf.sh 2.4.0"
echo "© 2020 iDépanne – L'expert informatique"
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
