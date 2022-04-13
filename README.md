# Dbms_Project

## Note:
* Backing up before commit: `mysqldump erp > backup.sql`
* Modifying erp schema: `mysql erp < erp.sql`

## Todo:
* create: CREATE DATABASE `university` /*!40100 DEFAULT CHARACTER SET
utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT
ENCRYPTION='N' */;
* Mysql user, access rights, setup db & user code

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
## Creating Database
* drop database erp;
* create database erp;
* exit;

## Instructing Flask about the working of server
* export $(cat src/conf.env | xargs)

## Creating Fake Data for 'erp' database
* mysql erp < erp.sql
* python3 src/zombie.py

## Starting server for transfer of data
* python3 src/web.py
