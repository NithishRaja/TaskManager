# TASK MANAGER

Simple task managing system with admin assigning task to workers and update task upon completion

## GETTING STARTED

* use Netbeans and create a JSP web project
* replace the web folder in the project directory with the folder in this repo
* create database taskmanager with tables as specified below
* finally run the project using netbeans

## EDITING CODE

* code can be found inside `/web` directory
* main code is inside `/web/src` directory
* static files are found inside `/web/static` directory

## DATABASES

* employee table: id VARCHAR(20) PRIMARY KEY AUTO_INCREMENT, name VARCHAR(20), email VARCHAR(40), isAdmin VARCHAR(10)

* tasklist table: id INT(20) PRIMARY KEY AUTO_INCREMENT, department VARCHAR(40), worker_assigned INT(20), status VARCHAR(20), remarks VARCHAR(40), description VARCHAR(40)
