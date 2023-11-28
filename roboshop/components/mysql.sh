#!bin/bash

COMPONENT=mysql
COMPONENT_URL="https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/${COMPONENT}.repo"
SCHEMA_URL="https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"

source components/common.sh

echo -e *********"\e[31m configuring ${COMPONENT} \e[0m"*******

echo -n "Configuring $COMPONENT repo:"
curl -s -L -o /etc/yum.repos.d/mysql.repo  &>> $LOGFILE $COMPONENT_URL
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

echo -n "show databases;" | mysql -uroot -pRoboShop@1 &>> $LOGFILE
if [ $? -ne 0 ]; then
    echo -n "Changing $COMPONENT root password :"
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1'"| mysql --connect-expired-password -uroot -p$DEFAULT_ROOT_PASS &>> $LOGFILE
    stat $?
fi

echo "show plugins;" | mysql -uroot -pRoboShop@1 | grep validate_password &>> $LOGFILE
if [ $? -eq 0 ]; then
    echo -n "uninstall password validation plugins: "
    echo -n "uninstall plugin validate_password;" | mysql -uroot -pRoboShop@1 &>> $LOGFILE
    stat $?
fi
   
echo -n "Downloading the $COMPONENT schema :"
curl -s -L -o /tmp/mysql.zip $SCHEMA_URL &>> $LOGFILE
stat $?

echo -n "Extracting $COMPONENT schema :"
cd /tmp
unzip ${COMPONENT}.zip
cd ${COMPONENT}-main
mysql -u root -pRoboShop@1 <shipping.sql