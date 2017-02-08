#!/bin/bash
clear
echo "         _
 __ __ _(_)_ _ ___ _ __  ___ _ _ __
 \ V  V / | '_/ -_) '  \/ _ \ '_/ -_)
  \_/\_/|_|_| \___|_|_|_\___/_| \___|"
echo
echo "Welcome to Wiremore";echo "Script creator WPA/WPA2 Wireless command line connector"; echo
iwconfig
read -p "What's the your computer network board interface? " board
ifconfig $board up
iwlist $board scan | grep ESSID
read -p "What's the network ESSID that you'd like to connect? " network
read -s -p "What's the $network's password? " pass
echo
read -p "Choose a path for the script: " path
while ! [ -e $path ]; do
echo "Invalid path, choose another!"
read -p "Choose a path for the script: " path
done
echo "ifconfig $board up; iwconfig $board ESSID "$network"; wpa_passphrase "$network" $pass > $path/"$network".conf; wpa_supplicant -Dwext -i$board -c$path/"$network".conf -B; ps; dhclient $board" > $path/"$network".sh
sudo chmod 777 $path/"$network".sh
if [ -e $path/"$network".sh ]; then
read -p "The $network's connection script has been created, would you like to run it now?[Y/n] " answer0
case $answer0 in
Y|y) echo "If the configurated network script doesn't work, that's probabily because your board interface it's busy with another network process, reboot the system and then run again"
     sleep 2
     $path/"$network".sh ;;
N|n) echo "Bye"
     exit ;;
esac
else
echo "Unfortunately, the script couldn't be created"
fi
