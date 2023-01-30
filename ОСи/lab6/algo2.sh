#!/bin/bash

name=`cat "./files/$1"`

for ((i=0; i<14000; i++))
do
    digit=${name:$i:1}
    let digit*=2
    echo "$digit" >> "./files/$1";
done

