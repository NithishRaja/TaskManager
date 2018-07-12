# TASK MANAGER

Simple task managing system to monitor and allocate tasks in a project

## GETTING STARTED

* use Netbeans and create a JSP web project
* replace the web folder in the project directory with the folder in this repo
* create MySQL database **taskmanager** with tables as specified below
* go into commons class and change config values to your liking
* import all libraries/JAR files mentioned below
* finally run the project using Netbeans

## EDITING CODE

* code can be found inside `/web` directory
* main code is inside `/web/src` directory
* custom packages are inside `/src/java` directory
* static files are found inside `/web/static` directory

## DATABASES

* department table: id INT(20) PRIMARY KEY AUTO_INCREMENT, department_name VARCHAR(80), department_group VARCHAR(40)
* worker table: id INT(20) PRIMARY KEY AUTO_INCREMENT, name VARCHAR(20), email VARCHAR(40), department_id INT(20), status VARCHAR(20), password VARCHAR(20)
* tasklist table: id INT(20) PRIMARY KEY AUTO_INCREMENT, department_id INT(20), worker_id INT(20), description VARCHAR(80), remarks VARCHAR(40), status VARCHAR(20), date DATE
* files: id INT(20) PRIMARY KEY AUTO_INCREMENT, task_id INT(20), filepath VARCHAR(80), file_name VARCHAR(80)

## LIBRARIES USED

* `java.mail.internet`
* `org.apache.commons.fileupload`
* `org.apache.commons.io`
* `java.sql`
* `org.apache.poi`

## FEATURES

* Any user can enter new tasks
* Admin can assign tasks to employees, get report on employees and get overall report
* Admin can view files uploaded by employees
* Admin can reopen closed tasks if necessary
* Employees can start working on task, upload files regarding the task, close task
