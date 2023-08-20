#!/bin/bash

user="rbarakat"
remote_user="rbar"
remote_ip="10.0.2.5"


mkdir -p "/home/$user/.ssh"
chmod 700 "/home/$user/.ssh"

ssh-keygen -f "/home/$user/.ssh/id_rsa"

ssh-copy-id -i "/home/$user/.ssh/id_rsa.pub" "$remote_user@$remote_ip"

ssh "$remoteuser@$remote_ip"
