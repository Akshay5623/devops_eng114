sudo apt update -y

sudo apt upgrade -y

sudo apt install nginx -y

sudo systemctl start nginx

sudo systemctl enable nginx

sudo curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

sudo apt install nodejs -y

sudo apt install npm

sudo apt install python-software-properties -y

# go back to root on vm

sudo cp default /etc/nginx/sites-available/

sudo systemctl restart nginx

sudo systemctl enable nginx

# go back to right app folder on vm
# npm install -d #- May not be needed as npm has been installed earlier

# npm start