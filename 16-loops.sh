#!/bin/bash


# Loops : When you want to run an action for certain number of times, we use loops.

# There are 2 major types of loops ; 
#     1) For loop       ( When you know something to be executed n number of times, we use for loop)
#     2) While loop     ( When you don't know something to be executed n number of times, we use while loop)

# echo Value is 10
# echo Value is 20 
# echo Value is 30
# echo Value is 40
# echo Value is 50 

 for loop syntax is for i in the range then semi colon then put do then echo words and $i, type done on next line
for i in 10 20 30 40 50 ; do 
    echo "Vaules from the loop are $i"
done 