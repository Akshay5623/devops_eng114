#!/bin/bash

# Update
sudo apt-get update -y

# Upgrade
sudo apt-get upgrade -y

# Install
sudo apt-get install nginx -y

# Start nginx
sudo systemctl start nginx

# Enable nginx
sudo systemctl enable nginx

# Download Nodejs v6
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

# Install Nodejs v6
sudo apt-get install nodejs -y

# Install pm2
sudo npm install pm2 -g

# Install python software
sudo apt-get install python-software-properties -y

# Redirect into correct folder
cd app/app/app/

# Install npm
npm install -d

# Start npm
npm start -d
