#!/bin/bash
while true
do 
read line
case $line in

    "TERM") 
        kill -SIGTERM $(cat .pid)
        exit 0
    ;;
    "+")
        kill -USR1 $(cat .pid)
    ;;
    "*")
        kill -USR2 $(cat .pid)
    ;;
    *)
    :
    ;;    
esac
done