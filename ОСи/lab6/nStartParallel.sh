#!/bin/bash
n=$1
result=111

for ((i=0; i<$n; i++))
do
bash ./algo.sh $result &
pids[${i}]=$!
let result++
done

for p in ${pids[*]}
do
wait $p
done