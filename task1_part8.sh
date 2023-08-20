#!/bin/bash

sudo systemctl stop firewalld
sudo systemctl disable firewalld

sudo systemctl enable iptables
sudo systemctl start iptables

sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

sudo iptables-save

#sudo iptables -A INPUT -s 10.0.2.4 -j DROP
