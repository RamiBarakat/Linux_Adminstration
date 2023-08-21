#!/bin/bash

sudo yum install -y mariadb
sudo yum install -y mysqld

systemctl start mariadb
systemctl enable mariadb

sudo iptables -A INPUT -p tcp --dport 3306 -j ACCEPT

cat << EOF >> /etc/mycnf.d
[mysqld]
skip-networking=0
skip-bind-address
bind-address = 0.0.0.0
EOF

sudo systemctl restart mariadb


mysql -u root << EOF
drop database if exists studentdb;
create database studentdb;
drop user if exists user@localhost;
create user 'user4'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON studentdb.* to 'user4'@'10.0.2.5' IDENTIFIED BY 'password' WITH GRANT OPTION;
FLUSH PRIVILEGES;
exit
EOF

<<"COMMENT"
mysql -u user -ppassword<< EOF
use studentdb;
create table students(
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    program VARCHAR(50) NOT NULL,
    grad_year INT NOT NULL,
    student_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
);
insert into students(first_name,last_name,program,grad_year,student_number) values 
('Allen', 'Brown', 'mechanical', '2017', '110-001'),
('David', 'Brown', 'mechanical', '2017', '110-002'),
('Mary', 'Green', 'mechanical', '2018', '110-003'),
('Dennis', 'Green', 'electrical', '2018', '110-004'),
('Joseph', 'Black', 'electrical', '2018', '110-005'),
('Dennis', 'Black', 'electrical', '2020', '110-006'),
('Ritchie', 'Salt', 'computer science', '2020', '110-007'),
('Robert', 'Salt', 'computer science', '2020', '110-008'),
('David', 'Suzuki', 'computer science', '2020', '110-009'),
('Mary', 'Chen', 'computer science', '2020', '110-010');
exit
EOF
COMMENT
