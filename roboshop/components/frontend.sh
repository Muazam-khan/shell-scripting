#!/bin/bash

COMPONENT=frontend

source components/common.sh

echo -e *********"\e[31m configuring ${COMPONENT} \e[0m"*******

echo -n "Installing Nginx :"
yum install nginx -y   &>> $LOGFILE
stat $?

echo -n "Downloading Component ${COMPONENT} :"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -n "Cleanup of ${COMPONENT} : "
cd /usr/share/nginx/html # cleanup is enter into usr directory
rm -rf *  &>> /tmp/frontend.log # and remove these files and redirect to log files
stat $?

echo -n "Extracting ${COMPONENT} : "   #gave echo of extracting bcz unzip is same thing
unzip /tmp/frontend.zip  &>> $LOGFILE  # moved extracted files to logs
stat $?

echo -n "Configuring $COMPONENT :"
mv ${COMPONENT}-main/* .
mv static/* .
rm -rf ${COMPONENT}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Updating Reverse Proxy: "
    for component in catalogue user cart shipping ; do 
       sed -i -e "/${component}/s/localhost/${component}.roboshop.internal/" /etc/nginx/default.d/roboshop.conf
    done
stat $?

echo -n "Restarting $COMPONENT :"
systemctl enable nginx &>> $LOGFILE
systemctl daemon-reload &>> $LOGFILE
systemctl start nginx &>> $LOGFILE
stat $?

echo -e *********"\e[31m $COMPONENT Configuration is completed \e[0m"*******
