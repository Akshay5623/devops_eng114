# Vagrant.configure("2") do |config|
# New Vagrant file configuration

#Vagrant.configure("2") do |config|
#
#	config.vm.define "db" do |db|
#   db.vm.box = "ubuntu/xenial64"
#   db.vm.network "private_network", ip: "192.168.10.150"
#		#copy provision file over
#		db.vm.provision "file", source: "./db_provision.sh", destination: "$HOME/"
#		#copy over mongodb config
#		db.vm.provision "file", source: "./mongod.conf", destination: "$HOME/"
#		#gives the provison.sh file ablity to execute
#		db.vm.provision "shell", inline: "sudo chmod +x db_provision.sh"
#		#Runs the file
#		db.vm.provision "shell", inline: "sudo ./db_provision.sh"
#
#
#	end
#
#	config.vm.define "app" do |app|
#   app.vm.box = "ubuntu/xenial64"
#  	app.vm.network "private_network", ip: "192.168.10.100"
# 	# app.vm.provision "file", source: "./file.sh", destination: "$HOME/"
#   # app.vm.provision "file", source: "./default", destination: "$HOME/" 
#   app.vm.provision "shell",
#   path: "./file.sh", run: "always"
#   app.vm.synced_folder "./app", "/home/vagrant/app"
#	end
#
#end



#   config.vm.box = "ubuntu/xenial64"

#   # add a private network betwen local host and VM using ip
#   config.vm.network "private_network", ip: "192.168.10.100"

#   # add an external script to run on vagrant up
#   # config.vm.provision "file", source: "./file.sh", destination: "$HOME/"

#   # copy nginx config file to VM
#   # config.vm.provision "file", source: "./default", destination: "$HOME/" 

#   # Change permissions of file to executable
#    config.vm.provision "shell",
#     path: "./file.sh", run: "always"
  
#   # Synced app folder
#     # cp everything from current location create a folder called app - copy everything from localhost
#   config.vm.synced_folder "./app", "/home/vagrant/app"
  

# end

# Vagrant.configure("2") do |config|
  
#   config.vm.define "app" do |app|
#     app.vm.box = "ubuntu/xenial64"
#     app.vm.network "private_network", ip: "192.168.10.100"
#     # app.vm.provision "file", source: "./file.sh", destination: "$HOME/"
#     # app.vm.provision "file", source: "./default", destination: "$HOME/" 
#     app.vm.provision "shell",
#     path: "./file.sh", run: "always"
#     app.vm.synced_folder "./app", "/home/vagrant/app"

#   end

#   config.vm.define "db" do |db|
#     db.vm.box = "ubuntu/xenial64"
#     db.vm.network "private_network", ip: "192.168.10.150"

#   end
# end

# Vagrantfile for Ansible

# -*- mode: ruby -*-
 # vi: set ft=ruby :
 
 # All Vagrant configuration is done below. The "2" in Vagrant.configure
 # configures the configuration version (we support older styles for
 # backwards compatibility). Please don't change it unless you know what
 
 # MULTI SERVER/VMs environment 
 #
 Vagrant.configure("2") do |config|
  # creating are Ansible controller
    config.vm.define "controller" do |controller|
      
     controller.vm.box = "bento/ubuntu-18.04"
     
     controller.vm.hostname = 'controller'
     
     controller.vm.network :private_network, ip: "192.168.33.12"
     
     # config.hostsupdater.aliases = ["development.controller"] 
     
    end 
  # creating first VM called web  
    config.vm.define "web" do |web|
      
      web.vm.box = "bento/ubuntu-18.04"
     # downloading ubuntu 18.04 image
  
      web.vm.hostname = 'web'
      # assigning host name to the VM
      
      web.vm.network :private_network, ip: "192.168.33.10"
      #   assigning private IP
      
      #config.hostsupdater.aliases = ["development.web"]
      # creating a link called development.web so we can access web page with this link instread of an IP   
          
    end
    
  # creating second VM called db
    config.vm.define "db" do |db|
      
      db.vm.box = "bento/ubuntu-18.04"
      
      db.vm.hostname = 'db'
      
      db.vm.network :private_network, ip: "192.168.33.11"
      
      #config.hostsupdater.aliases = ["development.db"]     
    end
  
  
  end
