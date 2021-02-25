#!/bin/bash

# Disable screen blanking
xset s noblank
xset s off
xset -dpms

# Enable SSH
sudo systemctl enable ssh
sudo systemctl start ssh

sudo apt update
sudo apt upgrade -y
# Install Node, npm, pm2, socket.io
sudo apt install -y nodejs npm realvnc-vnc-server
sudo npm i -g pm2 socket.io

# Setup RealVNC
sudo systemctl enable vncserver-x11-serviced.service
sudo systemctl start vncserver-x11-serviced.service

# Create pm2 instance to run on startup and monitor script
sudo pm2 start /home/pi/fieldboard/fboard.js --watch
sudo env PATH=$PATH:/usr/local/bin pm2 startup -u pi

# Todo
# Watch for css or html update, install Zerotier and add to network, VNC, Chrome Watch, Initialize to refresh?, USB Tunneling, ead-only, html/java cases, Set Resolution
