#!/bin/bash
# 1GB/ 512bytes ~= 2100000 sectors

fdisk /dev/sdb <<EOF
n
p
1

2100000
t
8e
w
EOF



#create a PV
sudo pvcreate /dev/sdb1

#create a VG with extent size as 16MB
sudo vgcreate -s 16MB vg1 /dev/sdb1

#create a volumegroup 
sudo lvcreate -l 50 vg1 -n lv1

#set file system to ext4
sudo mkfs.ext4 -m 0 /dev/vg1/lv1

sudo mkdir /mnt/data

sudo mount /dev/vg1/lv1 /mnt/data

#automatic mounting
echo "/dev/vg1/lv1      /mnt/data       ext4    defaults        0       0" >> /etc/fstab

mount -a
