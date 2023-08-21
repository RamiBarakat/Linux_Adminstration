#!/bin/bash

useradd -u 601 -s /sbin/nologin user1

addgroup TrainingGroup
addgroup admin

passwd user1 << EOF
redhat
redhat
EOF


usermod -a -G TrainingGroup user1
#usermod -g TrainingGroup user1

useradd user2
useradd user3

usermod -a -G admin user2
usermod -a -G admin user3

#wheel is a root like group
usermod user3 -a -G wheel
#echo "user3 ALL=(ALL) NOPASSWD:ALL >> /etc/sudoers
