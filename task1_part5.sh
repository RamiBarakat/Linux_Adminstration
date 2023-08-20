#!/bin/bash

sed -i 's/SELINUX=permissive/SELINUX=enforcing/g' /etc/sysconfig/selinux
setenforce 1
