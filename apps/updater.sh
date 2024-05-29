#!/bin/bash
# Pi-Hole Host Project Updater
# updater.sh
# [1398]
# © 2019-2024 iDépanne – L'expert informatique
# idepanne.support.tech@free.fr

echo ""
echo ""
echo ""
echo "+=============================================================================+"
echo "|  • Suppression des logiciels obsolètes                                      |"
echo "+=============================================================================+"
echo ""
echo "sudo rm -rv ~/Apps/backup.sh"
sudo rm -rv ~/Apps/backup.sh
echo ""
echo ""
echo ""
echo "+=============================================================================+"
echo "|  • Mise à jour de Raspberry Pi OS                                           |"
echo "+=============================================================================+"
echo ""
sudo pkill apt-get
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
	echo "$ sudo systemctl status --no-pager -l fail2ban.service"
	sudo systemctl status --no-pager -l fail2ban.service
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
    #cd || return
	echo ""
	echo ""
	echo ""
	echo "$ cd /var/www/html/ || return"
	cd /var/www/html/ || return
	echo ""
 	echo ""
	cd || return
	echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/html/stop_pub_idepanne_400.jpg > stop_pub_idepanne_400.jpg"
	wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/html/stop_pub_idepanne_400.jpg > stop_pub_idepanne_400.jpg
    echo ""
    echo "$ sudo mv -v stop_pub_idepanne_400.jpg /var/www/html/stop_pub_idepanne_400.jpg"
    sudo mv -v stop_pub_idepanne_400.jpg /var/www/html/stop_pub_idepanne_400.jpg
    echo ""
	echo ""
    echo "$ sudo mv -v /var/www/html/index.lighttpd.html /var/www/html/index.lighttpd.html.old"
    sudo mv -v /var/www/html/index.lighttpd.html /var/www/html/index.lighttpd.html.old
	echo ""
	echo ""
	echo "$ wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/html/index.html > index.html"
	wget -O - https://raw.githubusercontent.com/idepanne/pi-hole_hosts_project/master/apps/html/index.html > index.html
    echo ""
    echo "$ sudo mv -v index.html /var/www/html/index.html"
    sudo mv -v index.html /var/www/html/index.html
	echo ""
    echo ""
    sudo systemctl status --no-pager -l cloudflaredv4.service
    echo ""
    sudo systemctl status --no-pager -l cloudflaredv6.service
else
	echo "4. Pi-hole :                    [NON INSTALLÉ]"
    echo ""
fi
echo ""
echo ""
if [[ -d "/etc/ssmtp" ]]; then
	echo "5. sSMTP :                      [MISE À JOUR EN COURS]"
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
	echo "5. sSMTP :                      [NON INSTALLÉ]"
fi
echo ""
echo ""
echo ""
var55=$(fastfetch --version)
if [[ "$var55" =~ "fastfetch 2.13.2 (aarch64)" ]]; then
	echo "6. Fastfetch :                      [LOGICIEL À JOUR]"
else
	echo "6. Fastfetch :                      [MISE À JOUR EN COURS]"
	echo ""
    echo "cd || return && wget -O - https://github.com/fastfetch-cli/fastfetch/releases/download/2.13.2/fastfetch-linux-aarch64.deb > fastfetch-linux-aarch64.deb && sudo dpkg -i fastfetch-linux-aarch64.deb ; sudo rm -rv fastfetch-linux-aarch64.deb"
    cd || return && wget -O - https://github.com/fastfetch-cli/fastfetch/releases/download/2.13.2/fastfetch-linux-aarch64.deb > fastfetch-linux-aarch64.deb && sudo dpkg -i fastfetch-linux-aarch64.deb ; sudo rm -rv fastfetch-linux-aarch64.deb
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
if [[ -f "Apps/email.sh" ]]; then
	crontab <<<"0 0 29 * * ~/Apps/email.sh > ~/Apps/log/$(hostname -s)_$(date --date='+1month' +'%Y%m')_email_automate.txt 2>&1 ; sleep 5 ; echo 'Fichier log envoi emails' | mail -s '$(hostname -s)' -A ~/Apps/log/$(hostname -s)_$(date --date='+1month' +'%Y%m')_email_automate.txt idepanne.support.tech@free.fr
0 1 * * * ~/Apps/autoupdate.sh > ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_autoupdate.txt 2>&1 ; sleep 5 ; ~/Apps/resume.sh > ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_resume.txt 2>&1 ; sleep 5 ; echo 'Fichiers logs de $(hostname -s)' | mail -s '$(hostname -s)' -A ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_autoupdate.txt -A ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_resume.txt idepanne.support.tech@free.fr
15 1 * * 1,4 sudo reboot >/dev/null 2>&1"
else
	crontab <<<"0 1 * * * ~/Apps/autoupdate.sh > ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_autoupdate.txt 2>&1 ; sleep 5 ; ~/Apps/resume.sh > ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_resume.txt 2>&1 ; sleep 5 ; echo 'Fichiers logs de $(hostname -s)' | mail -s '$(hostname -s)' -A ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_autoupdate.txt -A ~/Apps/log/$(hostname -s)_$(date --date='+1day' +'%Y%m%d')_resume.txt idepanne.support.tech@free.fr
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