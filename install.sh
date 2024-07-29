#!/bin/bash

# This script is meant to run on a clean fresh system

ISYAY=/sbin/yay
if [ -f "$ISYAY" ]; then 
    echo -e "yay was located, moving on.\n"
    yay -Suy
else 
    echo -e "yay was not located, please install yay. Exiting script.\n"
    exit 
fi

### Disable wifi powersave mode ###
read -n1 -rep 'Would you like to disable wifi powersave? (y,n)' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "The following has been added to $LOC.\n"
    echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC
    echo -e "\n"
    echo -e "Restarting NetworkManager service...\n"
    sudo systemctl restart NetworkManager
    sleep 3
fi

pacman -S --noconfirm zoxide

yay -S --noconfirm hyprland kitty waybar swaybg swaylock-effects wofi wlogout mako thunar polkit-gnome python-requests starship swappy grim slurp pamixer brightnessctl gvfs bluez bluez-utils lxappearance xfce4-settings dracula-gtk-theme dracula-icons-git xdg-desktop-portal-hyprland waypaper noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra ttf-font-awesome ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono

# Start the bluetooth service
echo -e "Starting the Bluetooth Service...\n"
sudo systemctl enable --now bluetooth.service
sleep 2

# Clean out other portals
echo -e "Cleaning out conflicting xdg portals...\n"
yay -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk

### Copy Config Files ###
echo -e "Copying config files...\n"
cp -R hypr ~/.config/
cp -R kitty ~/.config/
cp -R mako ~/.config/
cp -R waybar ~/.config/
cp -R swaylock ~/.config/
cp -R wofi ~/.config/

# Set some files as exacutable 
chmod +x ~/.config/hypr/xdg-portal-hyprland
chmod +x ~/.config/waybar/scripts/waybar-wttr.py

### Install the starship shell ###
echo -e "Updating .bashrc...\n"
echo -e '\neval "$(starship init bash)"' >> ~/.bashrc
echo -e "copying starship config file to ~/.config ...\n"
cp starship.toml ~/.config/


### Script is done ###
echo -e "Script had completed.\n"
echo -e "You can start Hyprland by typing Hyprland (note the capital H).\n"
read -n1 -rep 'Would you like to start Hyprland now? (y,n)' HYP
if [[ $HYP == "Y" || $HYP == "y" ]]; then
    exec Hyprland
else
    exit
fi
