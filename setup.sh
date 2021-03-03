#!/bin/bash

# Upgrade
sudo apt update
sudo apt upgrade -y

# Move Toolbar
sudo cp /etc/xdg/lxpanel/LXDE-pi/panels/panel ~/.config/lxpanel/LXDE-pi/panels/ 
sudo sed -i 's/edge=top/edge=bottom/' ~/.config/lxpanel/LXDE-pi/panels/panel

# Update Hostname
read -p "New Hostname: " replace
echo $replace | sudo tee /etc/hostname
echo '127.0.1.1      ' $replace | sudo tee -a /etc/hosts

## Force Hotplug
echo 'hdmi_force_hotplug=1' | sudo tee -a /boot/config.txt

## Set Resolution

## Background and Trashcan
pcmanfm --set-wallpaper "/home/pi/fieldboard/bg.png"
sudo sed -i 's/show_trash=1/show_trash=0/' ~/.config/pcmanfm/LXDE-pi/desktop-items-0.conf

## Disable screen blanking
sudo sed -i 's/$/ consoleblank=0/' /boot/cmdline.txt

# Enable SSH
sudo systemctl enable ssh
sudo systemctl start ssh



# Install Node, npm, pm2, socket.io
sudo apt install -y nodejs npm unclutter
sudo npm i -g pm2
cd /home/pi/fieldboard/
sudo npm i socket.io

# Setup RealVNC
sudo apt install -y realvnc-vnc-server
sudo systemctl enable vncserver-x11-serviced.service
sudo systemctl start vncserver-x11-serviced.service

## Create pm2 instance to run on startup and monitor script
sudo pm2 start /home/pi/fieldboard/fboard.js --watch
sudo env PATH=$PATH:/usr/local/bin pm2 startup -u pi

## Set up ZeroTier
curl -s https://install.zerotier.com | sudo bash
sudo zerotier-cli join 3efa5cb78a8c50a6

## Chrome Autorun
echo "
[Unit]
Description=Chromium Kiosk
Wants=graphical.target
After=graphical.target

[Service]
Environment=DISPLAY=:0.0
Environment=XAUTHORITY=/home/pi/.Xauthority
Type=simple
ExecStart=/bin/bash /home/pi/kiosk.sh
Restart=on-abort
User=pi
Group=pi

[Install]
WantedBy=graphical.target" | sudo tee  /lib/systemd/system/kiosk.service

sudo systemctl enable kiosk.service

## Read-Only


