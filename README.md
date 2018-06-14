# TASK MANAGER

Simple task managing system with admin assigning task to workers and update task upon completion

## GETTING STARTED

* use Netbeans and create a JSP web project
* replace the web folder in the project directory with the folder in this repo
* create database **taskmanager** with tables as specified below
* finally run the project using Netbeans

## EDITING CODE

* code can be found inside `/web` directory
* main code is inside `/web/src` directory
* static files are found inside `/web/static` directory

## DATABASES

* department table: id INT(20) PRIMARY KEY AUTO_INCREMENT, department_name VARCHAR(20)
* worker table: id INT(20) PRIMARY KEY AUTO_INCREMENT, name VARCHAR(20), email VARCHAR(40), department_id INT(20), status VARCHAR(20)
* tasklist table: id INT(20) PRIMARY KEY AUTO_INCREMENT, department_id INT(20), worker_id INT(20), description VARCHAR(80), remarks VARCHAR(40), status VARCHAR(20), date DATE
* files: id INT(20) PRIMARY KEY AUTO_INCREMENT, task_id INT(20), filepath VARCHAR(40), file_name VARCHAR(20)
