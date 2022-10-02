#!/bin/bash
# Pi-Hole Host Project Updater
# updater.sh
# [1125]
# © 2020-2022 iDépanne – L'expert informatique
# idepanne67@gmail.com

echo ""
echo ""
echo ""
echo "+=============================================================================+"
echo "|  • Suppression des logiciels obsolètes                                      |"
echo "+=============================================================================+"
echo ""
var60=$(sudo apt-get purge -y speedtest-cli)
if [[ "$var60" =~ "n'est pas installé, et ne peut donc être supprimé" ]]; then
	echo "Aucun logiciel obsolète à supprimer."
else
	echo "$ sudo apt-get purge -y speedtest-cli" 
	echo "$var60"
fi
echo ""
echo ""
echo ""
echo "+=============================================================================+"
echo "|  • Mise à jour de Raspberry Pi OS                                           |"
echo "+=============================================================================+"
echo ""
echo "$ sudo apt-get full-upgrade -y"
sudo apt-get full-upgrade -y
echo ""
echo ""
echo ""
cd ~/Apps
echo "+=============================================================================+"
echo "|  • Mise à jour des logiciels                                                |"
echo "+=============================================================================+"
echo ""
echo "1. autoupdate.sh :              [INSTALLÉ]"
echo ""
echo "$ sudo mv autoupdate.sh autoupdate_old.sh"
sudo mv autoupdate.sh autoupdate_old.sh
echo ""
echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate.sh > autoupdate.sh"
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/autoupdate.sh > autoupdate.sh
echo ""
echo "$ sudo chmod +x autoupdate.sh"
sudo chmod +x autoupdate.sh
echo ""
echo "1. autoupdate.sh :              [MIS À JOUR]"
echo ""
echo ""
echo ""
if [[ -d "/etc/fail2ban" ]]; then
	echo "2. Fail2ban :                   [INSTALLÉ]"
	echo ""
	echo "$ sudo rm -rv /etc/fail2ban/jail.conf"
	sudo rm -rv /etc/fail2ban/jail.conf
	echo ""
	echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/fail2ban/jail.conf > jail.conf"
	wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/fail2ban/jail.conf > jail.conf
	echo ""
	echo "$ sudo mv jail.conf /etc/fail2ban/jail.conf"
	sudo mv jail.conf /etc/fail2ban/jail.conf
	echo ""
	echo "$ sudo chown root:root /etc/fail2ban/jail.conf"
	sudo chown root:root /etc/fail2ban/jail.conf
	echo ""
	echo "$ sudo service fail2ban restart"
	sudo service fail2ban restart
	echo ""
	sleep 3
	echo "$ sudo systemctl --no-pager status fail2ban"
	sudo systemctl --no-pager status fail2ban
	echo ""
	sleep 3
	echo "$ sudo iptables -L -n"
	sudo iptables -L -n
	echo ""
	echo "$ sudo fail2ban-client status sshd"
	sudo fail2ban-client status sshd
	echo ""
	echo "2. Fail2ban :                   [MIS À JOUR]"
else
	echo "2. Fail2ban :                   [NON INSTALLÉ]"
fi
echo ""
echo ""
echo ""
if [[ -d "/etc/pihole" ]]; then
	echo "3. Pi-hole :                    [INSTALLÉ]"
	echo ""
	sudo pihole -v
	echo ""
	var50=$(sudo pihole -up)
	echo "$var50"
	if [[ "$var50" =~ "update available" ]]; then
		echo ""
	else
		echo ""
		sudo pihole -g
		echo ""
	fi
	echo "3. Pi-hole :                    [MIS À JOUR]"
else
	echo "3. Pi-hole :                    [NON INSTALLÉ]"
fi
echo ""
echo ""
echo ""
cd
if [[ -f "Apps/backup.sh" ]]; then
	echo "4. backup.sh :                  [INSTALLÉ]"
	echo ""
	cd ~/Apps && wget -O - https://raw.githubusercontent.com/idepanne/backup_to_nas/master/apps/backup.sh > backup.sh && sudo chmod +x backup.sh && cd
	echo ""
	echo "4. backup.sh :                  [MIS À JOUR]"
else
	echo "4. backup.sh :                  [NON INSTALLÉ]"
fi
echo ""
echo ""
echo ""
echo "+=============================================================================+"
echo "|  • Configuration du crontab                                                 |"
echo "+=============================================================================+"
echo ""
echo "Ancien crontab :"
crontab -l
echo ""
cd
if [[ -f "Apps/backup.sh" ]]; then
	crontab <<<"0 3 * * * ~/Apps/autoupdate.sh > ~/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
30 3 * * * ~/Apps/backup.sh
0 4 * * 1 sudo reboot"
else
	crontab <<<"0 3 * * * ~/Apps/autoupdate.sh > ~/Apps/log/`date --date="+1day" +"%Y%m%d"`_autoupdate.log 2>&1
0 4 * * 1 sudo reboot"
fi
sudo /etc/init.d/cron restart
echo ""
echo "Nouveau crontab :"
crontab -l
echo ""
echo ""
echo ""
echo "+=============================================================================+"
echo "|  • Nettoyage et optimisation                                                |"
echo "+=============================================================================+"
echo ""
cd
echo "Avant nettoyage :"
sudo du -h /var/cache/apt/
if [[ -d ".local/share/Trash/" ]]; then
	sudo du -h ~/.local/share/Trash/
fi
if [[ -d ".cache/thumbnails/" ]]; then
	sudo du -h ~/.cache/thumbnails/
fi
echo ""
echo "$ cd"
cd
echo ""
echo "$ sudo apt-get autopurge -y"
sudo apt-get autopurge -y
echo ""
echo "$ sudo apt-get autoremove -y"
sudo apt-get autoremove -y
echo ""
echo "$ sudo apt-get autoclean -y"
sudo apt-get autoclean -y
echo ""
echo "$ sudo apt-get clean all"
sudo apt-get clean all
echo ""
echo "$ sudo apt-mark auto $(apt-mark showmanual | egrep 'linux-.*[0-9]')"
sudo apt-mark auto $(apt-mark showmanual | egrep 'linux-.*[0-9]')
echo ""
cd
if [[ -d "Apps" ]]; then
	echo "$ cd ~/Apps"
	cd ~/Apps
	echo ""
	echo "$ sudo rm -rv *_old.sh"
	sudo rm -rv *_old.sh
	echo ""
	cd
	if [[ -d "Apps/log" ]]; then
		echo "$ cd ~/Apps/log"
		cd ~/Apps/log
		echo ""
		echo "$ find *.log -mtime +31 -exec rm -rv {} \;"
		find *.log -mtime +31 -exec rm -rv {} \;
		echo ""
	fi
fi
cd
if [[ -d ".local/share/Trash/" ]]; then
	echo "$ sudo rm -rfv ~/.local/share/Trash/files/*"
	sudo rm -rfv ~/.local/share/Trash/files/*
	echo ""
	echo "$ sudo rm -rfv ~/.local/share/Trash/expunged/*"
	sudo rm -rfv ~/.local/share/Trash/expunged/*
	echo ""
	echo "$ sudo rm -rfv ~/.local/share/Trash/info/*"
	sudo rm -rfv ~/.local/share/Trash/info/*
	echo ""
fi
cd
if [[ -d ".cache/thumbnails/" ]]; then
	echo "$ sudo rm -rfv ~/.cache/thumbnails/*"
	sudo rm -rfv ~/.cache/thumbnails/*
	echo ""
fi
cd
echo "Après nettoyage :"
sudo du -h /var/cache/apt/
if [[ -d ".local/share/Trash/" ]]; then
	sudo du -h ~/.local/share/Trash/
fi
if [[ -d ".cache/thumbnails/" ]]; then
	sudo du -h ~/.cache/thumbnails/
fi
