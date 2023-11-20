#!/bin/bash 

echo "$$"    # $$  is going to print the PID of the current proces 
echo '$$'    # Single Quotes Always Eliminates The Power Of The Special Variable 

echo $?      # This prints the exit code of the last command
echo "$?"     # This prints the exit code of the last command 
echo '$?'     # This should not print the exit code of the last command as single quote killed the power