#!/bin/bash
cd ~/Apps
echo "###############################################################################"
echo "#                                                                             #"
echo "#                    Pi-Hole Host Project Updater 8.2.1b12                    #"
echo "#                                autoupdate.sh                                #"
echo "#                 © 2020-2022 iDépanne – L'expert informatique                #"
echo "#                           https://fb.me/idepanne/                           #"
echo "#                            idepanne67@gmail.com                             #"
echo "#                                                                             #"
echo "###############################################################################"
echo ""
echo ""
echo ""
var0=$(cat /proc/cpuinfo | grep Model)
if [[ $var0 == *"Raspberry Pi"* ]]; then
    echo "==============================================================================="
    echo "   • Test de la connexion Internet"
    echo "==============================================================================="
    echo ""
    echo ""
    if ping -c 3 1.1.1.1 &> /dev/null; then
    	echo "Connexion Internet : OK"
    	echo ""
    	echo ""
    	echo ""
    	wget -O - https://raw.githubusercontent.com/idepanne/infosys/master/infosys-rpi.sh > infosys-rpi.sh && sudo chmod +x infosys-rpi.sh && ./infosys-rpi.sh
        echo ""
    	echo ""
    	echo "==============================================================================="
    	echo "   • Vérification des connexions actives"
    	echo "==============================================================================="
    	echo ""
    	netstat -t | grep 'ESTABLISHED'
    	echo ""
    	echo ""
    	echo ""
    	echo "==============================================================================="
    	echo "   • Mise à jour de updater.sh"
    	echo "==============================================================================="
    	echo ""
    	echo "$ sudo mv updater.sh updater_old.sh"
    	sudo mv updater.sh updater_old.sh
    	echo ""
    	echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/updater.sh > updater.sh"
    	wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/updater.sh > updater.sh
    	echo ""
    	echo "$ sudo chmod +x updater.sh"
    	sudo chmod +x updater.sh
    	./updater.sh
    else
    	echo "Connexion Internet : Echec"
    	echo ""
    	echo ""
    	echo "*** Abandon des mises à jour | Nouvelle tentative dans 24h ***"
        var20=$(ls /usr/bin/*session)
        if [[ $var20 == *"lxsession"* || $var20 == *"openbox"*  || $var20 == *"pipewire-media"* ]]; then
            sleep
        else
        	if [[ -d "/home/pi/Apps" ]]; then
        		echo ""
    	    	echo ""
    	    	echo ""
    		    echo "==============================================================================="
    		    echo "   • Mise à jour du crontab"
    		    echo "==============================================================================="
    		    echo ""
    		    echo "Ancien crontab :"
    		    crontab -l
    		    echo ""
    		    if [[ -f "/home/pi/Apps/backup.sh" ]]; then
    		    	crontab <<<"0 3 * * * /home/pi/Apps/autoupdate.sh > /home/pi/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
30 3 * * * /home/pi/Apps/backup.sh
0 4 * * 0 sudo reboot"
    		    else
    		    	crontab <<<"0 3 * * * /home/pi/Apps/autoupdate.sh > /home/pi/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
0 4 * * 0 sudo reboot"
    		    fi
    		    sudo /etc/init.d/cron restart
    		    echo ""
    		    echo "Nouveau crontab :"
    		    crontab -l
    	    fi
        fi
    fi
    echo ""
    echo ""
    echo ""
    echo "###############################################################################"
    echo "#                                                                             #"
    echo "#                    Mise à jour du Raspberry Pi terminée                     #"
    echo "#                                                                             #"
    echo "###############################################################################"
    echo ""
    sleep 1
else
    echo "Ce programme de mise à jour n'est compatible qu'avec les Raspberry Pi."
    echo "Il ne peut pas être utilisé sur une autre distribution Linux."
    echo ""
    echo ""
    cd
    sudo rm autoupdate.sh
fi
