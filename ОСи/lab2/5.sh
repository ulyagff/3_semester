#!/bin/bash
echo "" > out5.log
ppid=0
sum_art=0
count=0
while read line
do
new_ppid=$(echo $line | grep -E -h -s -i -o "Parent_ProcessID=[0-9]+" | grep -o "[0-9]\+")
new_art=$(echo $line | grep -E -h -s -i -o "Average_Running_Time=[0-9.]+" | grep -o "[0-9.]\+" | awk '{printf("%s",$1)}')
if [[ $ppid == $new_ppid ]]
then
count++
echo "$line" >> out5.log
else
sum_art=$( echo "scale=2;$sum_art/$count" | bc )
echo "Average_Running_Children_of_ParentID=$ppid is $sum_art" >> out5.log
echo $line >> out5.log

sum_art=0
count=1
fi
sum_art=$( echo "scale=2;$sum_art+$new_art" | bc )
ppid=$new_ppid

done < out4.log