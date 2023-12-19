#!/bin/bash
cd ~/Apps || return
echo "+=============================================================================+"
echo "|                         Pi-Hole Host Project Updater                        |"
echo "|                                  resume.sh                                  |"
echo "|                                   [1295]                                    |"
echo "|                © 2020-2023 iDépanne – L'expert informatique                 |"
echo "|                        idepanne.support.tech@free.fr                        |"
echo "+=============================================================================+"
echo ""
echo ""
echo ""

###### Définition des variables ######
varsys=$(< /etc/os-release grep PRETTY_NAME | cut -c14- | rev | cut -c2- | rev)
var18=$(uptime -s)
var19=$(uptime -p)
######################################

echo "+=============================================================================+"
echo "|  • Résumé                                                                   |"
echo "+=============================================================================+"
echo ""
echo -n "Nom d'hôte      :  "; hostname -s
echo ""
echo -n "Système         :  "; echo "$varsys"
echo ""
echo -n "Température     :  "; echo "$(vcgencmd measure_temp | grep -E -o '[0-9]*\.[0-9]*')°C"
echo ""
echo -n "IPv4/IPv6       :  "; hostname -I
echo ""
echo -n "Démarré depuis  :  "; echo "$var18 - $var19"
echo ""
echo "Analyse du boot :"
systemd-analyze
echo ""
echo ""
echo "Fail2ban        :"
echo ""
sudo fail2ban-client status sshd
if [[ -d "/etc/pihole" ]]; then
    echo ""
    echo ""
    echo "Pi-hole         :"
    echo ""
    sudo timeout 1 pihole -c  > ~/Apps/temp.txt 2>&1 ; sed -i '1,8d' ~/Apps/temp.txt
    cat ~/Apps/temp.txt
    sudo rm -rv ~/Apps/temp.txt >/dev/null 2>&1
    echo ""
    echo ""
    echo "Cloudflared     :"
    echo ""
    sudo systemctl status --no-pager cloudflared
    echo ""
    echo ""
    dig @127.0.0.1 -p 5053 raspberrypi.com
else
    echo >/dev/null 2>&1
fi
