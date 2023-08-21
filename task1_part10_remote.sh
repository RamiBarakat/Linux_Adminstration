#!/bin/bash
#connect from a remote user to the mariadb

#telnet 10.0.2.15 3306 --> to test the connectiom

sudo yum install mariadb

sudo systemctl start mariadb
sudo systemctl enable mariadb

mysql -u user4 -h 10.0.2.15 -ppassword << EOF
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
