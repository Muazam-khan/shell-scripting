#!/bin/bash

# DATE="17JULY2023"

DATE=$(date +%A)
NO_OF_SESSIONS=$(who|wc -l)
echo -e "Good Morning , Today's date is \e[37m $DATE \e[0m" 
echo -e "Total Number Of Connected Sessions : \e[37m $NO_OF_SESSIONS \e[0m"