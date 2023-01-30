#!/bin/bash
n=$1
result=111

for ((i=0; i<$n; i++))
do
a=$(bash ./algo.sh $result)
let result++
done

