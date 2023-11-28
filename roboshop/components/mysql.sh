#!bin/bash

COMPONENT=mysql

source components/common.sh

echo -e *********"\e[31m configuring ${COMPONENT} \e[0m"*******

echo -n "Configuring $COMPONENT repo:"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo &>> $LOGFILE
stat $?

echo -n "Installing $COMPONENT :"
yum install mysql-community-server -y &>> $LOGFILE
stat $?

echo -n "Starting $COMPONENT :"
systemctl enable mysqld &>> $LOGFILE
systemctl start mysqld &>> $LOGFILE
stat $?

echo -n "Extracting $COMPONENT default root password :"
DEFAULT_ROOT_PASS=$(sudo grep "temporary password" /var/log/mysqld.log | awk -F " " '{print $NF}')
stat $?

echo -n "Changing $COMPONENT root password :"
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1'"| mysql --connect-expired-password -uroot -p$DEFAULT_ROOT_PASS &>> $LOGFILE
stat $?

