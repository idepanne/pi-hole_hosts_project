#!/bin/bash
SECONDS=0
clear
cd
echo "                   'o:::::::::::::::::::::lc                                   "
echo "                   lc                     .O                                   "
echo "                   lc   ;cccl'   'll;:ll' .O                                   "
echo "                   lc  dMMMMMk   oMMOXMMl .O                                   "
echo "      cXMNd        lc  dMMMMMx   cKKdOKKc .O :d:::::::oo                       "
echo "      OMMMN.       lc   dXKXK:   cXXx0XXc .O o:       'k  .,,,.                "
echo "       ;l:.        lc                     .O o:       'k .0...0.               "
echo "  ,OOOOOOOkxo;.    cx,,,,,,,,,,,,,,,,,,,,,ck o: .''.  'k .O . O.               "
echo "  cMMxccccldKMWd    .........x;''x.........  o:       'k .O   O.               "
echo "  cMM,       ;XMO      od.  ;xxddxl          ,o:::::::lc  l:::c                "
echo "  cMM, :d:    :MM;    lx.                                                      "
echo "  cMM, kMk    'MMc .xOxxOk' .K0kxxOx.  lOkxk0k. 'XOkxOKd  ;XkkxOKd  .oOkxkO:   "
echo "  cMM, kMk    :MM;.WK'...0W..WN'   0N..l; ..dMl ,M0   oMc :Mx   kM: 0W:...dMl  "
echo "  cMM, kMk   'XMO ;MKdddddd..W0    xM'.kKOkdkMl ,Mx   cMl :Mc   dMc.NNdddddd:  "
echo "  cMM, kMKco0MWx  .KX,  .OO..WWl  ;NO xMd  .kMo ,Mx   cMl :Mc   dMc dWl. .oK,  "
echo "  ;00. o000kd:.     cxOOkl. .WNdkOx:  .lkkkd:xl .k:   ,k, 'k,   :k,  ,dOOOd'   "
echo "                            .WX                                                "
echo "           .                 c:   .     ''                  .                  "
echo "       l  .,.;:',,';. .;;.;,.d:'  ;..,.:d;'' ,,';.:,. .;..d,:' ': '.'.:,       "
echo "       o..  dc:'kc:d:ckc:lc .o,   l,ko:ll.d:lx  Ocd;lcldd.d.'cocx:olld::       "
echo "       ...  .'..:cco..,:...  ..   .  . ., .. .  ' . ... . .  .'.:.. ..'        "
echo "            .lc;.                                                              "
echo ""
echo ""
echo ""
echo ""
echo "                               infosys.sh 5.0.0                                "
echo "                 © 2020-2021 iDépanne – L'expert informatique                  "
echo "                            https://fb.me/idepanne/                            "
echo ""
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "                              Informations système                             "
echo "-------------------------------------------------------------------------------"
echo ""
cat /proc/cpuinfo | grep Model
cat /proc/cpuinfo | grep Serial
echo ""
var1=$(lscpu | grep "Model name:" | sed -r 's/Model name:\s{1,}//g')
var2=$(lscpu | grep "Vendor ID:" | sed -r 's/Vendor ID:\s{1,}//g')
echo -n "Processeur      : " && echo "$var2 $var1"
cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))
echo -n "Température     : "; echo CPU temp"="$cpuTemp1"."$cpuTempM"'C"
echo -n "                  "; echo GPU $(/opt/vc/bin/vcgencmd measure_temp)
echo ""
echo -n "Firmware        : "
/opt/vc/bin/vcgencmd version
echo ""
echo -n "EEPROM          : "
sudo rpi-eeprom-update
echo ""
echo -n "Système         : "; uname -sr
echo -n "IPv4/IPv6       : "; hostname -I
echo ""
var3=$(uptime -s)
var4=$(uptime -p)
echo -n "Démarré depuis  : " && echo "$var3 - $var4"
echo ""
echo "Synchronisation de l'horloge :"
sudo systemctl daemon-reload
timedatectl timesync-status && timedatectl
echo ""
echo "Stockage        : "
df -h /
df -h | grep /var/log
echo ""
echo "RAM             : "
free -ht
echo ""
echo ""
echo ""
duration=$SECONDS
echo "Durée d'exécution: $(($duration / 60)) min $(($duration % 60)) sec"
