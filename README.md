# Dbms_Project SRS (System Requirement Specification)


notion link = https://www.notion.so/Procedures-and-Views-467384a763654d2e8a19fad254eabf24


# Installation Guidelines :::
## Required Libraries:
1. Flask
2. Faker
3. python-mysqldb

### Steps to install required libraries:
#### Python-MysqlDB
* sudo apt-get update
* sudo add-apt-repository 'deb http://archive.ubuntu.com/ubuntu bionic main'
* sudo add-apt-repository universe 
* sudo apt-get install build-essential python-dev libmysqlclient-dev
* sudo apt-get install -y python3-pip
* sudo apt-get install python3-setuptools
* sudo apt-get install python-mysqldb
* pip install mysql-python
* pip install mysqlclient

#### Flask
* pip install Flask

#### Faker
* pip install Faker

# Installation Process :::

## Initializing Database and Schema
* mysql < erp.sql

## Instructing Flask about the working of server
* export $(cat src/conf.env | xargs)

## Creating Fake Data for 'erp' database
* python3 src/zombie.py

## Starting server for transfer of data
* python3 src/web.py

## Testing the App : 
* Open the file client/login.html in your browser to proceed
* Use the username and id of any student in Database as 'Username' and 'Password' for the login page respectively