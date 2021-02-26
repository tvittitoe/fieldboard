#!/bin/bash

# Disable screen blanking


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

# Set up ZeroTier
curl -s https://install.zerotier.com | sudo bash
sudo zerotier-cli join 3efa5cb78a8c50a6

# Todo
# Watch for css or html update, Chrome Watch, Initialize to refresh?, USB Tunneling, ead-only, html/java cases, Set Resolution,
#Fix screen blanking, set background, move toolbar

