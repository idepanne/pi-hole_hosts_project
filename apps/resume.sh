#!/bin/bash
cd ~/Apps || return
echo "+=============================================================================+"
echo "|                         Pi-Hole Host Project Updater                        |"
echo "|                                  resume.sh                                  |"
echo "|                                   [1379]                                    |"
echo "|                © 2019-2024 iDépanne – L'expert informatique                 |"
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
echo "Serveurs DNS         :  "
cat /etc/resolv.conf
echo ""
echo -n "Démarré depuis    :  "; echo "$var18 - $var19"
echo ""
echo "Analyse du boot   :"
systemd-analyze
echo ""
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
    sudo systemctl status --no-pager -l cloudflaredv4.service
    echo ""
    sudo systemctl status --no-pager -l cloudflaredv6.service
else
    echo >/dev/null 2>&1
fi
if [[ -d "/etc/nut" ]]; then
    echo ""
    echo ""
    echo ""
    echo "Network UPS Tools :"
    echo ""
    varserver=$(sudo grep 0.0.0.0 /etc/nut/upsd.conf)
    if [[ $varserver == *"LISTEN 0.0.0.0 3493"* ]]; then
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
        echo ""
        sudo systemctl restart nut-server
        sleep 2
        sudo systemctl restart nut-monitor
        sleep 2
        echo "  • Status :"
        sudo systemctl status --no-pager -l nut-server.service
        echo ""
        sudo systemctl status --no-pager -l nut-monitor.service
    else
        sudo systemctl restart nut-monitor
        sleep 2
        echo "  • Status :"
        sudo systemctl status --no-pager -l nut-monitor.service
    fi
else
    echo >/dev/null 2>&1
fi
