#!/bin/bash

touch /var/tmp/admin
chmod +rw /var/tmp/admin

cp /etc/fstab /var/tmp/admin
sudo setfacl -m u:user1:rw /var/tmp/admin
sudo setfacl -m u:user2:--- /var/tmp/admin
