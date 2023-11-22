#!/bin/bash


# echo -e "Demo on if, if else, else if usage
  ACTION=$1
if  [ $ACTION == start ] ; then
  echo "Starting shipping service"
  exit 0
fi   