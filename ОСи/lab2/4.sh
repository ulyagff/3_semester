#!/bin/bash
echo "" > temp.txt
echo "" > debug.txt

for pid in $(ps -e --format="pid" | sed '1d')
do
    ppid_file="/proc/"$pid"/status"
    art_file="/proc/"$pid"/sched"
    if [ -e $ppid_file ] && [ -e $art_file ];
    then
    ppid=$(grep "PPid:" $ppid_file | grep -o "[0-9]\+")
    sum_exec_runtime=$(grep "^se.sum_exec_runtime" $art_file | grep -o "[0-9.]\+$")
    nr_switches=$(grep "^nr_switches" $art_file | grep -o "[0-9]\+")
    art=$(bc<<<"scale=2;$sum_exec_runtime/$nr_switches")
    echo "ProcessID=$pid : Parent_ProcessID=$ppid : Average_Running_Time=$art" >> temp.txt
    fi
done
sort -n -t: -k2.19 temp.txt > out4.log
sed -i '1d' out4.log
rm temp.txt