#!/bin/bash

ACTION=$1

if [ $ACTION == start ] ; then

 echo -e "\e[32m Starting Shipping Service \e[0m"
 exit 0
 fi

 echo "\e[34m Not met any conditions\e[om"
 exit 100