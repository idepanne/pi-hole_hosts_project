#!/bin/bash

# install2.sh 4.2.0b1
# © 2020-2021 iDépanne – L'expert informatique
# https://fb.me/idepanne/

echo ""
echo "-------------------------------------------------------------------------------"
echo "                      Installation des logiciels prérequis                     "
echo "-------------------------------------------------------------------------------"
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
echo "sudo apt-get update"
sudo apt-get update
echo ""
echo "sudo apt-get install -yf dnsutils"
sudo apt-get install -yf dnsutils
echo ""
echo "sudo apt-get install -yf debian-goodies"
sudo apt-get install -yf debian-goodies
echo ""
echo "sudo apt-get install -yf iftop"
sudo apt-get install -yf iftop
echo ""
echo "sudo apt-get install -yf ca-certificates git binutils"
sudo apt-get install -yf ca-certificates git binutils
echo ""
echo "sudo wget https://raw.githubusercontent.com/Hexxeh/rpi-update/master/rpi-update"
sudo wget https://raw.githubusercontent.com/Hexxeh/rpi-update/master/rpi-update
echo ""
echo "sudo mv rpi-update /usr/local/bin/rpi-update"
sudo mv rpi-update /usr/local/bin/rpi-update
echo "sudo chmod +x /usr/local/bin/rpi-update"
sudo chmod +x /usr/local/bin/rpi-update
echo ""
echo "mkdir log"
mkdir log
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "                            Mise à jour du firmware                            "
echo "-------------------------------------------------------------------------------"
echo ""
echo "sudo rpi-update"
sudo rpi-update
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "                            Mise à jour de l'EEPROM                            "
echo "-------------------------------------------------------------------------------"
echo ""
echo "sudo rpi-eeprom-update -a"
sudo rpi-eeprom-update -a
echo ""
./autoupdate_conf.sh
