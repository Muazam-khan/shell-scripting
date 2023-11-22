#!/bin/bash

ACTION=$1

if [ $ACTION == start ] ; then

 echo -e "\e[32m Starting Shipping Service \e[0m"
 exit 0
 elif [ $ACTION == stop ] ; then
   echo -e "\e[31m Stoppng Shipping Service \e[0m"
   exit 1
elif [ $ACTION == restart ] ; then
   echo -e "\e[33m restarting Shipping Service \e[0m"
   exit 2
else

 fi

 echo -e "\e[34m Not met any conditions\e[om"
 exit 100