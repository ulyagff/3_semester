#!/bin/bash

while true
do 
read line
echo "$line" > pipe

if [[ "$line" == "QUIT" ]];
	then
		echo "exit"
		exit 0
	fi

	if [[ "$line" != "+" && "$line" != "*" && "$line" =~ '^[0-9]+$' ]];
	then
		echo "Invalid string"
		exit 1
	fi

done