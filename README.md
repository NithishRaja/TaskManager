# TASK MANAGER

Simple task managing system with admin assigning task to workers and update task upon completion

## GETTING STARTED

* source code is in `/web` directory
* create database taskmanager with tables as specified below

## DATABASES

* employee table: id VARCHAR(20) PRIMARY KEY AUTO_INCREMENT, name VARCHAR(20), email VARCHAR(40), isAdmin VARCHAR(10)

* tasklist table: id INT(20) PRIMARY KEY AUTO_INCREMENT, department VARCHAR(40), worker_assigned INT(20), status VARCHAR(20), remarks VARCHAR(40), description VARCHAR(40)
