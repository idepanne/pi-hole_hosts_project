#!/bin/bash
		echo "$ wget https://raw.githubusercontent.com/jaykepeters/PSS/master/Pi-hole_SafeSearch.sh"
		wget https://raw.githubusercontent.com/jaykepeters/PSS/master/Pi-hole_SafeSearch.sh
		echo ""
		echo "sudo mv ./Pi-hole_SafeSearch.sh /usr/local/bin/"
		sudo mv ./Pi-hole_SafeSearch.sh /usr/local/bin/
		echo ""
		echo "sudo chmod a+x /usr/local/bin/Pi-hole_SafeSearch.sh"
		sudo chmod a+x /usr/local/bin/Pi-hole_SafeSearch.sh
		echo ""
		echo "sudo Pi-hole_SafeSearch.sh -e"
		sudo Pi-hole_SafeSearch.sh -e
