#!/bin/bash

ACTION=$1

if [ $ACTION == start ] ; then

 echo -e "\e[32m Starting Shipping Service \e[0m"
 exit 0
else
   echo -e "\e[31m Stoppng Shipping Service \e[0m"
   exit 1
 fi

 echo -e "\e[34m Not met any conditions\e[om"
 exit 100