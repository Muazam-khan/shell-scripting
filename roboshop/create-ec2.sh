#!/bin/bash

# this script is going to create Servers

#AMI_ID="ami-0f75a13ad2e340a58"  # hardcoding is a bad-choice particularly with AMI_ID as it is going to be changed when you register a new AMI.
COMPONENT=$1
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | sed -e 's/"//g')
SGID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=b56-allow-all" | jq ".SecurityGroups[].GroupId" | sed -e 's/"//g')
INSTANCE_TYPE="t3.micro"


echo -e "Server Creation In Progress: "

aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SGID} --tag-specifications "ResourceType=instance, Tags=[{Key=Name,Value=${COMPONENT}}]"