#!/bin/bash

let result=1
operation="+"

(tail -f pipe) | while true
do
    read line; 

    case $line in

    "QUIT") 
          echo "exit"
          killall tail
          exit 0
          ;;

    "+")
         operation="+"
         ;;

    "*")
         operation="*"
         ;;

    [0-9]*)
         if [[ "$operation" == "+" ]]; then
            let result+=$line
         else 
            let result=$result\*$line
         fi
         echo $result
          ;;

     *)
          echo "Invalid string"
          killall tail
          exit 1
          ;;
    esac

done 