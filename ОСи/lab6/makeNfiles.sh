#!/bin/bash

for ((i=1; i<=$1; i++))
do
name="$1$i$2"
bash ./algo2.sh $name &
pids[${i}]=$!
done

for p in ${pids[*]}
do
wait $p
done