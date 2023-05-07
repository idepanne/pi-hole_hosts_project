#!/bin/bash
cd ~/Apps || return
echo "+=============================================================================+"
echo "|                         Pi-Hole Host Project Updater                        |"
echo "|                                  resume.sh                                  |"
echo "|                                   [1241]                                    |"
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
sudo fail2ban-client status sshd
echo ""
echo ""
sudo timeout 1 pihole -c