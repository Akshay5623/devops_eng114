# Vagrant.configure("2") do |config|



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

Vagrant.configure("2") do |config|
  
  config.vm.define "app" do |app|
    app.vm.box = "ubuntu/xenial64"
    app.vm.network "private_network", ip: "192.168.10.100"
    # app.vm.provision "file", source: "./file.sh", destination: "$HOME/"
    # app.vm.provision "file", source: "./default", destination: "$HOME/" 
    app.vm.provision "shell",
    path: "./file.sh", run: "always"
    app.vm.synced_folder "./app", "/home/vagrant/app"

  end

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/xenial64"
    db.vm.network "private_network", ip: "192.168.10.150"

  end
end

