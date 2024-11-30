#!/bin/bash

APP_NAME="SpringBootRegistrationLogin"
JAR_FILE="/home/ubuntu/$APP_NAME.jar"
APP_DIR="/home/ubuntu/$APP_NAME"
BACKUP_DIR="/home/ubuntu/backup"
MYSQL_HOST="localhost"
MYSQL_USER="adt"
MYSQL_PASSWORD="adt12345"
MYSQL_DB="newlogindb"

echo "Stopping existing application..."
pkill -f $APP_NAME || true

echo "Backing up old JAR..."
mkdir -p $BACKUP_DIR
mv $JAR_FILE $BACKUP_DIR/${APP_NAME}_$(date +%F_%T).jar || true

echo "Deploying new JAR..."
mv /tmp/$APP_NAME.jar $JAR_FILE

echo "Starting application..."
nohup java -jar $JAR_FILE --spring.datasource.url=jdbc:mysql://$MYSQL_HOST:3306/$MYSQL_DB --spring.datasource.username=$MYSQL_USER --spring.datasource.password=$MYSQL_PASSWORD > /home/ubuntu/$APP_NAME.log 2>&1 &
