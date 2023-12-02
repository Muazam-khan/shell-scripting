#!/bin/bash

# this script is going to create Servers

#AMI_ID="ami-0f75a13ad2e340a58"  # hardcoding is a bad-choice particularly with AMI_ID as it is going to be changed when you register a new AMI.
if [ -z $1 ] ; then
    echo -e "\e[31m ****Component name is need ****\e[0m \n\t\t"
    echo -e "\e[36m **\t\tExample Usage : \e[0m bash create-ec2 ratings"
    exit 1
fi    
COMPONENT=$1
HOSTEDZONEID=""
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | sed -e 's/"//g')
SGID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=b56-allow-all" | jq ".SecurityGroups[].GroupId" | sed -e 's/"//g')
INSTANCE_TYPE="t3.micro"

create_server(){
    echo -e "******* \e[32m $COMPONENT \e[0m Server Creation In Progress ******* !!!!!!! "
    PRIVATE_IP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SGID} --tag-specifications "ResourceType=instance, Tags=[{Key=Name,Value=${COMPONENT}}]" | jq ".Instances[].PrivateIpAddress" | sed -e 's/"//g')
    echo -e "******* \e[32m $COMPONENT \e[0m Server Creation is completed ******* !!!!!!! \n\n"

    echo -e  ******* "\e[32m $COMPONENT \e[0m DNS Record Creation In Progress ******* !!!!!!! "
    sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${PRIVATE_IP}/" route53.json > tmp/dns.json
    

    aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file:///tmp/dns.json\
    echo -e  ******* "\e[32m $COMPONENT \e[0m DNS Record Creation In Completed ******* !!!!!!! \n\n"
 }
  # if user supplies all as first argument then all servers will be created
 if [ "$1" == "all" ]; then

        for component in mongodb cart user redis shipping payment catalogue mysql frontend rabbitmq payment; do 
            COMPONENT=$component
            create_server
        done    

else
     create-ec2
fi        
   