#!/bin/bash -v
sudo apt-get update
echo Y | sudo apt-get install default-jre
wait
echo Y | sudo apt-get install default-jdk
wait
echo y | sudo bin/plugin install cloud-aws
wget https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.3.0/elasticsearch-2.3.0.tar.gz -P ~/pkg
mkdir -p ~/elasticsearch
cd ~/elasticsearch && tar -zxvf ~/pkg/elasticsearch-2.3.0.tar.gz
cd ~/elasticsearch/elasticsearch-2.3.0
wait
echo -e "name: \"my-node-1\"" >> config/elasticsearch.yml
echo -e "cluster.name: \"flash-cluster\"" >> config/elasticsearch.yml
echo -e "#cloud.aws.access_key: \"XXXXXXXX\"" >> config/elasticsearch.yml
echo -e "#cloud.aws.secret_key: \"XXXXXXXXXXXXXXX\"" >> config/elasticsearch.yml
echo -e "#cloud.aws.region: \"us-east-1\"" >> config/elasticsearch.yml
echo -e "#discovery.type: \"ec2\"" >> config/elasticsearch.yml
echo -e "discovery.ec2.host_type: \"public_ip\"" >> config/elasticsearch.yml
echo -e "discovery.ec2.ping_timeout: \"30s\"" >> config/elasticsearch.yml
echo -e "http.cors.enabled: true" >> config/elasticsearch.yml
echo -e "http.cors.allow-origin: \"*\"" >> config/elasticsearch.yml
echo -e "http.host: \"0\"" >> config/elasticsearch.yml
echo -e "network.host: _ec2_" >> config/elasticsearch.yml
echo -e "transport.tcp.port: 9300" >> config/elasticsearch.yml
echo -e "http.port: 9200" >> config/elasticsearch.yml
wait
bin/elasticsearch > elastic.log