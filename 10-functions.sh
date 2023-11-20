b56(){
    echo "This is our b56 funtion"
    echo "We are learning functions"
    echo "Today date is:"
    date
    echo "function b56 is complete"
}

b56


stat(){
    echo "Number of sessions opened $(who|wc -l)"
    echo "Today's date is $(date +%F)"
    echo "AVG CPU Utilization in the last 5 min is : $(uptime|awk -F : '{print $NF}'|awk -F ',' '{print $2}')"
    b56 # calling a function from another function
}