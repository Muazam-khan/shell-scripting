#!/bin/bash

# conditions help us to execute something only if some factor is True/False

#syntax of case
 ACTION=$1

case $ACTION in
    start)
        echo -e "\e[32m Starting shipping service \e[om"
        exit 0
        ;;
    stop)
        echo -e "\e[31m Stoppng shipping service \e[om"
        exit 1
        ;;
    restart)
        echo -e "\e[33m Restarting shipping service \e[om"
        exit 2
        ;;
    *)
        echo -e "\e[32m Valid options are start-stop-restart only \e[om"
        echo -e "\e[36m Example usage: \e[om \nbash script.sh start"
        exit 3
esac         