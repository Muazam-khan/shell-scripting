#!/bin/bash

COMPONENT_URL="https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
APPUSER="roboshop"
APPUSER_HOME="/home/${APPUSER}/${COMPONENT}"
LOGFILE="/tmp/${COMPONENT}.log"
USER_ID=$(id -u)

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

    CREATE_USER(){

      echo -n "Creating $APPUSER: "
      id $APPUSER   &>> ${LOGFILE}
      if [ $? -ne 0 ] ; then    
         useradd $APPUSER
         stat $?
      else
          echo -e "\e[35m Skipping \e[0m"    
      fi  

 }

    DOWNLOAD_AND_EXTRACT(){

            echo -n "Downloading the $COMPONENT schema : "
            curl -S -L -o /tmp/${COMPONENT}.zip $COMPONENT_URL  &>> ${LOGFILE}
            stat $?

            echo -n "Performing cleanup of $COMPONENT: "
            rm -rf $APPUSER_HOME &>> $LOGFILE
            stat $?

            echo -n "Extracting ${COMPONENT} : "   #gave echo of extracting bcz unzip is same thing
            cd /home/${APPUSER}
            unzip -o /tmp/${COMPONENT}.zip   &>> $LOGFILE
            mv ${APPUSER_HOME}-main ${APPUSER_HOME}
            stat $?
    }
    
    CONFIG_SVC(){

            echo -n "Configuring $COMPONENT permissions :"
            #mv ${COMPONENT}-main $COMPONENT
            chown -R $APPUSER:$APPUSER  $APPUSER_HOME #changing ownership
            chmod -R 770  $APPUSER_HOME #changing permission, app component should be owned by app user
            stat $?

            echo -n "Configuring the $COMPONENT systemd file :"            
            sed -i -e 's/DBHOST/mysql.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' ${APPUSER_HOME}/systemd.service #sed to replace mongo dns
            mv ${APPUSER_HOME}/systemd.service /etc/systemd/system/${COMPONENT}.service #from project architect
            stat $?

    }

     START_SVC(){

        echo -n "Starting $COMPONENT servcie : "
        systemctl daemon-reload &>> $LOGFILE
        systemctl enable $COMPONENT &>> $LOGFILE
        systemctl restart $COMPONENT &>> $LOGFILE
        stat $?

    }

    JAVA(){
      echo -n "Installing Maven: "
      curl https://gitlab.com/thecloudcareers/opensource/-/raw/master/lab-tools/maven-java11/install.sh  &>> $LOGFILE
      stat $?
      CREATE_USER # calls create user function that creates roboshop user
      DOWNLOAD_AND_EXTRACT

      echo -n "Generating the artifacts: "
      cd $APPUSER_HOME
      mvn clean package &>> $LOGFILE  # generates the artifacts
      mv target/${COMPONENT}-1.0.jar ${COMPONENT}.jar
      stat $?

      CONFIG_SVC
      START_SVC
    }

  NODEJS(){

      echo -n "Configuring NodeJS Repo: "
      yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y &>> ${LOGFILE} || true
      stat $?

      echo -n "Installing nodejs: "
      yum install nodejs -y  &>> ${LOGFILE}
      stat $?

      CREATE_USER # calls create user function that creates roboshop user
      DOWNLOAD_AND_EXTRACT
      CONFIG_SVC 

      echo -n "Generating Artifacts :" #ACTION SPECIFIC TO NODEJS SO KEEPING HERE
      cd $APPUSER_HOME
      npm install  &>> $LOGFILE
      stat $?

      START_SVC

}

  

 