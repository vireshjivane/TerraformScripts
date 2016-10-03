#!/bin/bash -v
sudo apt-get update
sudo apt-get install default-jre -y
wait
sudo apt-get install default-jdk
wait
wget https://download.elastic.co/kibana/kibana/kibana-4.5.0-linux-x64.tar.gz -P ~/pkg
mkdir -p ~/kibana
cd ~/kibana && tar -zxvf ~/pkg/kibana-4.5.0-linux-x64.tar.gz
cd ~/kibana/kibana-4.5.0-linux-x64
sed -i 's/localhost/'"$1"'/g' /config/kibana.yml
./bin/kibana > /home/ubuntu/kibana.log