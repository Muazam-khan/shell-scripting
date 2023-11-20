#!/bin/bash

echo Welcome To Shell Scripting
echo "This is day 1 of our shell scripting"

# Escape Sequence characters

#  \n : New Line   backslash n is new line
# \t : tab Space   backslash t is a tab space

echo -e "Line1\nLine2\nLine3"
echo -e "\tLine4"     # we use -e after echo to enable special characters
echo -e "Line5\nLine6"
echo Line7

# Whenever you're using special characters , always enclose them in DOUBLE QUOTES
# " "  : Double Quotes 
# ' '  : Single Quotes