#!/bin/bash
x=$1
result=$x

for ((i=2; i<200000; i++))
do
let result=100*$x
let result/=10
x=$result
done

