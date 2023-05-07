#!/bin/bash
cd ~/Apps || return
echo "+=============================================================================+"
echo "|                         Pi-Hole Host Project Updater                        |"
echo "|                                  resume.sh                                  |"
echo "|                                   [1235]                                    |"
echo "|                © 2020-2023 iDépanne – L'expert informatique                 |"
echo "|                        idepanne.support.tech@free.fr                        |"
echo "+=============================================================================+"
echo ""
echo ""
echo ""

###### Définition des variables ######
var18=$(uptime -s)
var19=$(uptime -p)
######################################

echo "+=============================================================================+"
echo "|  • Résumé de la mise à jour                                                 |"
echo "+=============================================================================+"
echo ""
echo -n "Nom d'hôte      : "; hostname -s
echo ""
echo -n "Température     : "; echo "$(vcgencmd measure_temp | grep -E -o '[0-9]*\.[0-9]*')°C"
echo ""
echo -n "IPv4/IPv6       : "; hostname -I
echo ""
echo -n "Démarré depuis  : "; echo "$var18 - $var19"
echo ""
echo ""
echo "$ sudo fail2ban-client status sshd"
sudo fail2ban-client status sshd
echo ""
echo ""
var1000=$(sudo timeout 1 pihole -c)
sed -e '1d;2d;3d;4d' $var1000
echo "$var1000"