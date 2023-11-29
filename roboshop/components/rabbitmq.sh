#!bin/bash

COMPONENT=rabbitmq
#COMPONENT_URL="https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo"
#SCHEMA_URL="https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"

source components/common.sh

echo -e *********"\e[31m configuring ${COMPONENT} \e[0m"*******

echo -n "Configuring $COMPONENT repo:"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>> $LOGFILE 
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>> $LOGFILE 
stat $?

echo -n "Installing $COMPONENT :"
yum install rabbitmq-server -y &>> $LOGFILE
stat $?

echo -n "Starting $COMPONENT :"
systemctl enable rabbitmq-server &>> $LOGFILE
systemctl start rabbitmq-server &>> $LOGFILE
stat $?

echo -n "Creating $APPUSER for $COMPONENT:"
rabbitmqctl add_user roboshop roboshop123 &>> $LOGFILE
stat $?

echo -n "Sorting Permissions: "
rabbitmqctl set_user_tags roboshop administrator &>> $LOGFILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> $LOGFILE
stat $?

echo -e *********"\e[31m $COMPONENT Configuration is completed \e[0m"*******