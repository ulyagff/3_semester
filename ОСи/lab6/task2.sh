#!/bin/bash


for ((n=1; n<21; n++))
do
    for ((i=0; i<10; i++))
    do
        bash ./makeNfiles.sh $n $i
        date +"%H:%M:%S" >> time2MemParallel.log
    done
    echo "done $n"
done