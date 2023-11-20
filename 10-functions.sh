#!/bin/bash

# There are 4 types of commands available : 

# 1) Binary                   ( /bin  , /sbin )
# 2) Aliases                  ( Alises are shortcuts,  alias net="netstat -tulpn", ls is an alias command, gp is an alias cmd )
# 3) Shell Built-in Commands  
# 4) Functions           # Functions are nothing but a set of commands that can be written in a sequence and can be called n number of times as per your choice.


# How to declare a function ?

f() {
    echo Hye
}
# How do you call a function 

f   # calling a function

# sample() {
#     echo Hai from sample function
#     echo Sample function is completed
# }

# sample 

# echo sample call is completed 

# sample 

b56() {   # function declared here
    echo "This is our batch56 function"
    echo "We are learning functions"
    echo "Todays date is:"
    date 
    echo "function b56 is completed"
}


b56 # function is called here


stat() { # function stat being declared

    echo "Number of sessions opened $(who|wc -l)" #who displays session names, wc -l gives no of those
    echo "Todays date is $(date +%F)" # date cmd gives date
    echo "AVG Cpu Utilization In The Last 5 minues is : $(uptime|awk -F : '{print $NF}' | awk -F ',' '{print $2}')"
  #ist field separator was : and last field separt was comma and in last pipe we wanted 2nd argument of uptime to know 5 min
    b56  # calling a function from another function
}

stat  # called function stat here