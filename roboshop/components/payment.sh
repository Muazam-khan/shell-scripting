#!/bin/bash

COMPONENT=payment

echo -e *********"\e[31m configuring ${COMPONENT} \e[0m"*******

source components/common.sh

PYTHON   # calls python func

echo -e *********"\e[31m $COMPONENT Configuration is completed \e[0m"*******

