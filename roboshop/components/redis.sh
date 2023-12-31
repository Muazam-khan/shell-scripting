#!/bin/bash

COMPONENT=redis

source components/common.sh

echo -n "Configuring $COMPONENT Repo: "
curl -L https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/redis.repo -o /etc/yum.repos.d/${COMPONENT}.repo &>> $LOGFILE
stat $?

echo -n "Installing $COMPONENT: "
yum install redis-6.2.13 -y &>> $LOGFILE
stat $?

echo -n "Enabling $COMPONENT Visibility: "
sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/redis.conf
sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/redis/redis.conf
stat $?

echo -n "Starting $COMPONENT servcie : "
systemctl daemon-reload &>> $LOGFILE
systemctl enable $COMPONENT &>> $LOGFILE
systemctl restart $COMPONENT &>> $LOGFILE
stat $?

