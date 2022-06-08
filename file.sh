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

# Create and set the DB_HOST environment variable
# sudo echo "export DB_HOST=mongodb://192.168.10.150:27017/posts" >> /etc/bash.bashrc
# source ~/.bashrc

# Install Nodejs v6
sudo apt-get install nodejs -y

# Install pm2
sudo npm install pm2 -g

# Install python software
sudo apt-get install python-software-properties -y

# Copy over default and run it
sudo rm -rf /etc/nginx/sites-available/default
sudo cp default /etc/nginx/sites-available/
sudo systemctl restart nginx
sudo systemctl enable nginx

# Redirect into correct folder
cd app/app/app/

# Install npm
npm install -d

# Start npm
# npm start -d
