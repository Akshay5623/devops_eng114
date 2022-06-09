#!/bin/bash

# Get MongoDB keys
# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
# echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Update and Upgrade
# sudo apt-get update -y
# sudo apt-get upgrade -y

##install mongodb-org=3.2.20 -y
# sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20


# sudo systemctl restart mongod
# sudo systemctl enable mongod

# Copy over the new MongoDB config file and run it
# sudo rm -rf /etc/mongod.conf
# sudo cp mongod.conf /etc/mongod.conf

# sudo systemctl restart mongod
# sudo systemctl enable mongod