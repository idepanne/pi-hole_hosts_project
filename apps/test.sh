#!/bin/bash
echo "###############################################################################"
	echo "#                                A SUPPRIMER...                               #
	echo "###############################################################################"
	echo ""
	echo "Suppression du logiciel \"Pi-hole SafeSearch\"..."
	echo ""
	echo "$ sudo Pi-hole_SafeSearch.sh --disable"
	sudo Pi-hole_SafeSearch.sh --disable
	echo ""
	echo "$ sudo rm -rv /var/log/pss.log
	sudo rm -rv /var/log/pss.log
	echo ""
	echo "$ sudo rm -rv /etc/pss.ack
	sudo rm -rv /etc/pss.ack
	echo ""
	echo "$ sudo rm -rv /tmp/safesearch.txt
	sudo rm -rv /tmp/safesearch.txt
	echo ""
	echo "$ sudo rm -rv /etc/dnsmasq.d/05-restrict.conf
	sudo rm -rv /etc/dnsmasq.d/05-restrict.conf
	echo ""
	echo "$ sudo reboot"
	sudo reboot
