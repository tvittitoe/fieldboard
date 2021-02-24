#!/bin/bash

sudo apt update
# Install Node, npm, pm2, socket.io
sudo apt install -y nodejs npm
sudo npm i -g pm2 socket.io

# Create pm2 instance to run on startup and monitor script
sudo pm2 start /home/pi/scoreboard/lynx.js --watch
sudo env PATH=$PATH:/usr/local/bin pm2 startup -u pi

