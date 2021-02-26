#!/bin/bash

## Move Toolbar
sudo cp /etc/xdg/lxpanel/LXDE-pi/panels/panel ~/.config/lxpanel/LXDE-pi/panels/ 
sudo sed -i 's/edge=top/edge=bottom/' ~/.config/lxpanel/LXDE-pi/panels/panel

## Update Hostname
read -p "New Hostname: " replace
echo $replace | sudo tee /etc/hostname
echo '127.0.1.1      ' $replace | sudo tee -a /etc/hosts

## Force Hotplug

## Set Resolution

## Disable screen blanking
sudo sed -i 's/$/ consoleblank=0/' /boot/cmdline.txt


## Set Background

# Enable SSH
sudo systemctl enable ssh
sudo systemctl start ssh

# Upgrade
sudo apt update
sudo apt upgrade -y

# Install Node, npm, pm2, socket.io
sudo apt install -y nodejs npm 
sudo npm i -g pm2 socket.io

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

## USB Tunneling

## Chrom Autorun

## Read-Only


