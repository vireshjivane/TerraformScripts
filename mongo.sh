#!/bin/bash -v
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install mongodb-org -y > /home/ubuntu/mongo.log
cd /var && mkdir -p data/db/
cd /home/ubuntu/ && mkdir -p data/db
sudo sed -i "/bind_ip/"' s/^/#/' /etc/mongod.conf
sudo /usr/bin/mongod --dbpath /home/ubuntu/data/db/