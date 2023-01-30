#!/bin/bash
max_rss=0
for pid in $(ps -e --format="pid" | sed '1d')
do
    echo -n > rss_for_process
    rss=0
    rss_file="/proc/$pid/smaps"
    if [ -e $rrs_file ]
    then
        grep "Rss:" $rss_file | grep -o "[0-9]\+" >> rss_for_process
        while read rss_int
        do
            let rss+=$rss_int
        done < rss_for_process
        if [ "$rss" -gt "$max_rss" ]
        then
            max_rss=$rss
            ppid=$pid
        fi
    fi        
done 2> /dev/null

echo "PID: "$ppid" Memory: "$max_rss

top -o RES -b -n 1 | head -8 | tail -1 | awk '{print ("Top: " $1 " : " $6)}' 2> /dev/null