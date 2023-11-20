#!/bin/bash

# Special Variables are $0 to $9

# $0 has special privilege to print the name of script u r running

echo "Printing script Name :  $0"

echo "First Argument is : $1 "
echo "Second Argument is : $2 "
echo "Third Argument is : $3 "
echo "Fourth Argument is : $4 "
echo "Fifth Argument is : $5 "
echo "Sixth Argument is : $6 "
echo "Seventh Argument is : $7 "
echo "Eighth Argument is : $8 "
echo "Ninth Argument is : $9 "
echo "Tenth Argument is : $10 "
echo "Elenth Argument is : $11 "
echo "Twelvth Argument is : $12 "
echo $#
echo $?  # this cmd prints exit code of last command, if exit code is 0 , it means it was successful.
echo $*  # prints all arguments used
echo $@