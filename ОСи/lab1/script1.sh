#!/bin/bash

var1=$1

if [[ "$var1" -lt "$2" ]]
then
var1=$2
fi

if [[ "$var1" -lt "$3" ]]
then
var1=$3
fi

"$ans == "y"