#!/bin/bash

###### Définition des variables ######
var18=$(uptime -s)
var19=$(uptime -p)
######################################


echo -n "Nom d'hôte      : "; hostname -s
echo -n "Température     : "; echo "$(vcgencmd measure_temp | grep -E -o '[0-9]*\.[0-9]*')°C"
echo -n "IPv4/IPv6       : "; hostname -I
echo -n "Démarré depuis  : "; echo "$var18 - $var19"



echo "$ sudo fail2ban-client status sshd"
sudo fail2ban-client status sshd


sudo timeout 1 pihole -c