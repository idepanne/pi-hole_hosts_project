#!/bin/bash

# echo "autoupdate_conf.sh 3.2.0"
# echo "© 2020 iDépanne – L'expert informatique"
# echo "https://idepanne.now.site"

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
echo ""
echo "-------------------------------------------------------------------------------"
echo "   Mises à jour du système"
echo "-------------------------------------------------------------------------------"
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
echo "$ sudo apt-get full-upgrade -y"
sudo apt-get full-upgrade -y
echo ""
echo "$ sudo pihole -up"
sudo pihole -up
echo ""
echo "$ sudo pihole -g"
sudo pihole -g
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "   Nettoyage du système"
echo "-------------------------------------------------------------------------------"
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
echo "sudo rm -rv *_old.sh"
sudo rm -rv *_old.sh
echo ""
echo "sudo rm -rv *_new.sh"
sudo rm -rv *_new.sh
echo ""
echo "find /home/pi/logs/* -mtime +30 -exec rm -rv {} \;"
find /home/pi/logs/* -mtime +30 -exec rm -rv {} \;
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "   Recherche du programme d'installation"
echo "-------------------------------------------------------------------------------"
echo ""
var="$(find . -name 'install*')"
if [ "$var" == "" ]; then
        echo "Programme d'installation non détecté"
        echo "$var"
        echo ""
        echo "-------------------------------------------------------------------------------"
        echo "   Vérification des processus de mises à jour"
        echo "-------------------------------------------------------------------------------"
        echo ""
        var=$(sudo checkrestart)
        if [ "$var" = "Found 0 processes using old versions of upgraded files" ]; then
                echo "$var"
                echo ""
                echo ""
                echo "-------------------------------------------------------------------------------"
                echo "   Aucun redémarrage nécessaire"
                echo "-------------------------------------------------------------------------------"
        else
                echo "$var"
                echo ""
                echo ""
                echo "-------------------------------------------------------------------------------"
                echo "   Redémarrage du Raspberry Pi"
                echo "-------------------------------------------------------------------------------"
                sleep 1
                sudo reboot
        fi
else
        echo "Programme d'installation détecté..."
        echo "$var"
        echo ""
        echo "sudo rm -rv install*"
        sudo rm -rv install*
        echo ""
        echo ""
        echo "-------------------------------------------------------------------------------"
        echo "   Redémarrage et vérification de la structure du disque"
        echo "-------------------------------------------------------------------------------"
        sleep 1
        sudo shutdown -rF now
fi
