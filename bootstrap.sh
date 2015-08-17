#!/usr/bin/env bash

# Update package manager
apt-get update
apt-get upgrade

# Install GNU Screen
apt-get install -y screen

# Install Meteor
curl https://install.meteor.com/ | sh

# Download Meteor tool on initial run
cd /vagrant
meteor

# Fix shared directory
mkdir -p /home/vagrant/.meteor/local/
mount --bind /home/vagrant/.meteor/local/ /vagrant/.meteor/local/
echo "User ALL = NOPASSWD:/sbin/mount --bind /home/vagrant/.meteor/local/ /vagrant/.meteor/local/" >> /etc/sudoers.d/mounts
echo "mkdir -p /home/vagrant/.meteor/local/" >> ~/.bashrc
echo "sudo mount --bind /home/vagrant/.meteor/local/ /vagrant/.meteor/local/" >> ~/.bashrc

# Install NPM
apt-get install -y nodejs
apt-get install -y npm
ln -s /usr/bin/nodejs /usr/bin/node

# Install Mup
npm install -g mup

# Install JDK
apt-get update
apt-get install -y openjdk-7-jdk

# Install 32-bit libraries
apt-get install -y lib32z1 lib32stdc++6

if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi
