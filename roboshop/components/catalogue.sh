#!/bin/bash

USER_ID=$(id -u)
COMPONENT=catalogue
LOGFILE=" /tmp/${COMPONENT}.log"
$COMPONENT_URL="https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
APPUSER_HOME=/home/${APPUSER}/${COMPONENT}
APPUSER="roboshop"

stat(){
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m Success \e[0m"
   else
        echo -e "\e[31m Failure \e[0m"   
    fi
  }

if [ $USER_ID -ne 0 ] ; then
   echo -e "\e[32m This script is expected to be executed with sudo or as a root user\e[0m"
   echo -e "\e[31m Example usage: \n\t\t \e[0m sudo bash scriptName componentName"
   exit 1
fi

echo -n "Configuring NodeJS Repo: "
yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y  &>> ${LOGFILE}
stat $?

echo -n "Installing nodejs: "
yum install nodejs -y  &>> ${LOGFILE}
stat $?

echo -n "Creating $APPUSER: "
id $APPUSER   &>> ${LOGFILE}
if [ $? -ne 0 ] ; then    
    useradd $APPUSER
    stat $?
else
    echo -e "\e[35m Skipping \e[0m"    
fi    

echo -n "Downloading the $COMPONENT schema :"
curl -s -L -o /tmp/$COMPONENT.zip $COMPONENT_URL
stat $?

echo -n "Extracting ${COMPONENT} : "   #gave echo of extracting bcz unzip is same thing
cd /home/roboshop
$ unzip -o /tmp/${COMPONENT}.zip   &>> $LOGFILE
stat $?

echo -n "Configuring $COMPONENT permissions :"
mv ${APPUSER_HOME}-main $APPUSER_HOME
chown -R $APPUSER:$APPUSER  $APPUSER_HOME #changing ownership
chmod -R 770  $APPUSER_HOME #changing permission, app component should be owned by app user
stat $?

echo -n "Generating Artifacts :"
cd $APPUSER_HOME
npm install  &>> $LOGFILE
stat $?

#echo -n "Enabling $COMPONENT visibility :"
#sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
#stat $?