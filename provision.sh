#!/bin/bash
echo "192.168.122.111 alice" >> /etc/hosts
echo "192.168.122.112 bob" >> /etc/hosts
echo "192.168.122.113 charlie" >> /etc/hosts
echo "192.168.122.114 daisy" >> /etc/hosts

sudo cp -a /vagrant/.ssh /root/
sudo chown -R root:root /root/.ssh
sudo chmod 700 /root/.ssh
sudo chmod 600 /root/.ssh/id_rsa
sudo chmod 644 /root/.ssh/id_rsa.pub
sudo chmod 600 /root/.ssh/authorized_keys2
