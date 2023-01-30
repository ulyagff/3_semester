#!/bin/bash


for ((n=1; n<21; n++))
do
    for ((i=0; i<10; i++))
    do
        bash ./nStartParallel.sh $n
        date +"%H:%M:%S" >> time2parallel.log
    done
    echo "done $n"
done