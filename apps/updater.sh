#!/bin/bash
# Pi-Hole Host Project Updater
# updater.sh
# [1279]
# © 2020-2023 iDépanne – L'expert informatique
# idepanne.support.tech@free.fr

echo ""
echo ""
echo ""
echo "+=============================================================================+"
echo "|  • Désinstallation des logiciels obsolètes                                  |"
echo "+=============================================================================+"
echo ""
var60=$(sudo apt-get purge -y iftop)
if [[ "$var60" =~ "n'est pas installé, et ne peut donc être supprimé" ]]; then
	echo "Aucun logiciel obsolète à désinstaller."
else
	echo "$ sudo apt-get purge -y iftop"
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
echo "$ curl https://rclone.org/install.sh | sudo bash"
curl https://rclone.org/install.sh | sudo bash
rclone version
echo ""
echo ""
echo ""
cd ~/Apps || return
echo "+=============================================================================+"
echo "|  • Mise à jour des logiciels                                                |"
echo "+=============================================================================+"
echo ""
echo "1. autoupdate.sh :              [MISE À JOUR EN COURS]"
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
echo ""
echo ""
echo "2. resume.sh :                  [MISE À JOUR EN COURS]"
echo ""
echo "$ sudo mv resume.sh resume_old.sh"
sudo mv resume.sh resume_old.sh
echo ""
echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/resume.sh > resume.sh"
wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/resume.sh > resume.sh
echo ""
echo "$ sudo chmod +x resume.sh"
sudo chmod +x resume.sh
echo ""
echo ""
echo ""
if [[ -d "/etc/fail2ban" ]]; then
	echo "3. Fail2ban :                   [MISE À JOUR EN COURS]"
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
	echo "$ sudo systemctl --no-pager status fail2ban -l"
	sudo systemctl --no-pager status fail2ban -l
	echo ""
	sleep 3
	echo "$ sudo iptables -L -n"
	sudo iptables -L -n
	echo ""
	echo "$ sudo fail2ban-client status sshd"
	sudo fail2ban-client status sshd
else
	echo "3. Fail2ban :                   [NON INSTALLÉ]"
fi
echo ""
echo ""
echo ""
if [[ -d "/etc/pihole" ]]; then
	echo "4. Pi-hole :                    [MISE À JOUR EN COURS]"
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
	echo ""
	sudo timeout 1 pihole -c  > ~/Apps/temp.txt 2>&1 ; sed -i '1,8d' ~/Apps/temp.txt
    cat ~/Apps/temp.txt
    sudo rm -rv ~/Apps/temp.txt >/dev/null 2>&1
	echo ""
else
	echo "4. Pi-hole :                    [NON INSTALLÉ]"
fi
echo ""
echo ""
echo ""
cd || return
if [[ -f "Apps/backup.sh" ]]; then
	echo "5. backup.sh :                  [MISE À JOUR EN COURS]"
	echo ""
	cd ~/Apps && wget -O - https://raw.githubusercontent.com/idepanne/backup_to_nas/master/apps/backup.sh > backup.sh && sudo chmod +x backup.sh && cd || return
else
	echo "5. backup.sh :                  [NON INSTALLÉ]"
fi
echo ""
echo ""
echo ""
if [[ -d "/etc/ssmtp" ]]; then
	echo "6. sSMTP :                      [MISE À JOUR EN COURS]"
	echo ""
	echo "$ sudo rm -rv /etc/ssmtp/revaliases"
	sudo rm -rv /etc/ssmtp/revaliases
	echo ""
	echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/ssmtp/revaliases > revaliases"
	wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/ssmtp/revaliases > revaliases
	echo ""
	echo "$ sudo mv revaliases /etc/ssmtp/revaliases"
	sudo mv revaliases /etc/ssmtp/revaliases
	echo ""
	echo "$ sudo chown root:mail /etc/ssmtp/revaliases"
	sudo chown root:mail /etc/ssmtp/revaliases
##### A ACTIVER UNIQUEMENT SI BESOIN DE CHANGER LA CONFIGURATION DE SSMTP #####
#	echo ""
#	echo "$ sudo rm -rv /etc/ssmtp/ssmtp.conf"
#	sudo rm -rv /etc/ssmtp/ssmtp.conf
#	echo ""
#	echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/ssmtp/ssmtp.conf > ssmtp.conf"
#	wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/ssmtp/ssmtp.conf > ssmtp.conf
#	echo ""
#	echo "$ sudo mv ssmtp.conf /etc/ssmtp/ssmtp.conf"
#	sudo mv ssmtp.conf /etc/ssmtp/ssmtp.conf
#	echo ""
#	echo "$ sudo chown root:mail /etc/ssmtp/ssmtp.conf"
#	sudo chown root:mail /etc/ssmtp/ssmtp.conf
#####
else
	echo "6. sSMTP :                      [NON INSTALLÉ]"
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
cd || return
if [[ -f "Apps/backup.sh" ]]; then
    crontab <<<"0 1 * * * ~/Apps/autoupdate.sh > ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_autoupdate.txt 2>&1 ; sleep 5 ; ~/Apps/resume.sh > ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_resume.txt 2>&1 ; sleep 5 ; ~/Apps/backup.sh >/dev/null 2>&1
15 1 * * 1,4 sudo reboot >/dev/null 2>&1"
else
    crontab <<<"0 1 * * * ~/Apps/autoupdate.sh > ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_autoupdate.txt 2>&1 ; sleep 5 ; ~/Apps/resume.sh > ~/Apps/log/$(hostname -s)_$(date --date="+1day" +"%Y%m%d")_resume.txt 2>&1
15 1 * * 1,4 sudo reboot >/dev/null 2>&1"
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
cd || return
echo "Avant nettoyage :"
sudo du -h /var/cache/apt/
if [[ -d ".local/share/Trash/" ]]; then
	sudo du -h ~/.local/share/Trash/
fi
if [[ -d ".cache/thumbnails/" ]]; then
	sudo du -h ~/.cache/thumbnails/
fi
echo ""
echo "$ cd || return"
cd || return
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
echo '$ sudo apt-mark auto $(apt-mark showmanual | grep -E 'linux-.*[0-9]')'
sudo apt-mark auto $(apt-mark showmanual | grep -E 'linux-.*[0-9]')
echo ""
cd || return
echo "$ sudo rm -rv dead.letter"
sudo rm -rv dead.letter
echo ""
if [[ -d "Apps" ]]; then
	echo "$ cd ~/Apps || return"
	cd ~/Apps || return
	echo ""
	echo "$ sudo rm -rv *_old.sh"
	sudo rm -rv *_old.sh
	echo ""
	cd || return
	if [[ -d "Apps/log" ]]; then
		echo "$ cd ~/Apps/log || return"
		cd ~/Apps/log || return
		echo ""
		echo "$ find *.txt -mtime +31 -exec rm -rv {} \;"
		find *.txt -mtime +31 -exec rm -rv {} \;
		echo ""
	fi
fi
cd || return
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
cd || return
if [[ -d ".cache/thumbnails/" ]]; then
	echo "$ sudo rm -rfv ~/.cache/thumbnails/*"
	sudo rm -rfv ~/.cache/thumbnails/*
	echo ""
fi
cd || return
echo "Après nettoyage :"
sudo du -h /var/cache/apt/
if [[ -d ".local/share/Trash/" ]]; then
	sudo du -h ~/.local/share/Trash/
fi
if [[ -d ".cache/thumbnails/" ]]; then
	sudo du -h ~/.cache/thumbnails/
fi
