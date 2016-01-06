vagrant
=========
vagrant Download [Vagrant](https://www.vagrantup.com/)

#Install

###Install vagrant
---------
Download Page [vagrant](https://www.vagrantup.com/downloads.html)
Debian deb package[Deb Package](https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb)
```
Install OS image
Image Address[vagrantbox.es](http://www.vagrantbox.es/)
```

###Inital DEV
---------
```
vagrant box add image_alias_name ~/box/debian64.box
cd ~/dev
vagrant init image_alias_name
vagrant up
vagrant ssh
cd /vagrant         # switch to DEV path, ~/dev
```

###Command
---------
```
vagrant init        # inital
vagrant up          # Start
vagrant halt        # Shutdown
vagrant reload      # restart
vagrant ssh         # SSH to virtual machine
vagrant status      # Check vm status
vagrant destroy     # delete vm
vagrant package     # package ENV
```

