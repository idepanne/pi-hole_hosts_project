#!/bin/bash
cd ~/Apps || return
echo "+=============================================================================+"
echo "|                         Pi-Hole Host Project Updater                        |"
echo "|                                  resume.sh                                  |"
echo "|                                   [1331]                                    |"
echo "|                © 2020-2024 iDépanne – L'expert informatique                 |"
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
echo -n "Nom d'hôte        :  "; hostname -s
echo ""
echo -n "Système           :  "; echo "$varsys"
echo ""
echo -n "Température       :  "; echo "$(vcgencmd measure_temp | grep -E -o '[0-9]*\.[0-9]*')°C"
echo ""
echo -n "IPv4/IPv6         :  "; hostname -I
echo ""
echo -n "Démarré depuis    :  "; echo "$var18 - $var19"
echo ""
echo "Analyse du boot   :"
systemd-analyze
echo ""
echo ""
echo "Fail2ban          :"
echo ""
sudo fail2ban-client status sshd
if [[ -d "/etc/pihole" ]]; then
    echo ""
    echo ""
    echo "Pi-hole           :"
    echo ""
    sudo timeout 1 pihole -c  > ~/Apps/temp.txt 2>&1 ; sed -i '1,8d' ~/Apps/temp.txt
    cat ~/Apps/temp.txt
    sudo rm -rv ~/Apps/temp.txt >/dev/null 2>&1
    echo ""
    echo ""
	echo ""
    echo "Cloudflared       :"
    echo ""
    dig @127.0.0.1 raspberrypi.com A
    echo ""
    dig @::1 raspberrypi.com AAAA
else
    echo >/dev/null 2>&1
fi
if [[ -d "/etc/nut" ]]; then
    echo ""
    echo ""
    echo "Network UPS Tools :"
    echo ""
	upsc UPS@localhost ups.model > ~/Apps/temp.txt 2>&1 ; sed -i '1d' ~/Apps/temp.txt
    echo -n "  • Modèle     :  "; echo "$(cat ~/Apps/temp.txt)"
    sudo rm -rv ~/Apps/temp.txt >/dev/null 2>&1
    upsc UPS@localhost ups.status > ~/Apps/temp.txt 2>&1 ; sed -i '1d' ~/Apps/temp.txt
    echo -n "  • Status     :  "; echo "$(cat ~/Apps/temp.txt)"
    sudo rm -rv ~/Apps/temp.txt >/dev/null 2>&1
    upsc UPS@localhost battery.charge > ~/Apps/temp.txt 2>&1 ; sed -i '1d' ~/Apps/temp.txt
    echo -n "  • Charge     :  "; echo "$(cat ~/Apps/temp.txt)%"
    sudo rm -rv ~/Apps/temp.txt >/dev/null 2>&1
    upsc UPS@localhost battery.runtime > ~/Apps/temp.txt 2>&1 ; sed -i '1d' ~/Apps/temp.txt
    vartime1=$(cat ~/Apps/temp.txt)
    vartime2=$(echo $(($(($vartime1 - $vartime1/86400*86400))/3600))h $(($(($vartime1 - $vartime1/86400*86400))%3600/60))m $(($(($vartime1 - $vartime1/86400*86400))%60))s)
    echo -n "  • Autonomie  :  "; echo "$vartime2"
    sudo rm -rv ~/Apps/temp.txt >/dev/null 2>&1
    echo ""
    echo "  • Connexions :"
    netstat -t | grep 'ESTABLISHED'
else
    echo >/dev/null 2>&1
fi