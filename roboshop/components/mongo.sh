#!/bin/bash

COMPONENT=mongodb
MONGO_REPO="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"
SCHEMA_URL="https://github.com/stans-robot-project/mongodb/archive/main.zip"

source components/common.sh

echo -e *********"\e[31m configuring ${COMPONENT} \e[0m"*******

echo -n "Configuring $COMPONENT repo: "
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO
stat $?

echo -n "Installing $COMPONENT: "
yum install -y mongodb-org &>> ${LOGFILE}
stat $?

echo -n "Enabling $COMPONENT visibility :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "Starting $COMPONENT :"
systemctl enable mongod &>> $LOGFILE
systemctl daemon-reload &>> $LOGFILE
systemctl restart mongod &>> $LOGFILE
stat $?

echo -n "Downloading the $COMPONENT the schema :"
curl -s -L -o /tmp/mongodb.zip $SCHEMA_URL
stat $?

echo -n "Extracting ${COMPONENT} : "   #gave echo of extracting bcz unzip is same thing
cd /tmp
unzip -o /tmp/mongodb.zip  &>> $LOGFILE  # moved extracted files to logs
stat $?

echo -n "Injecting the schema: "
cd /tmp/mongodb-main
mongo < catalogue.js &>> $LOGFILE
mongo < users.js &>> $LOGFILE
stat $?

echo -e *********"\e[34m $COMPONENT Configuration is completed \e[0m"*******



