#!/bin/bash
while true
do

top -b | head -n4 | tail -n1 | awk '{print $6 " " $8}' >> mem.log
top -b | head -n5 | tail -n1 | awk '{print $5 " " $7}' >> swap.log
top -b | head -n8 | tail -n1 | awk '{print $10}' >> main.log
top -b | head -n12 | tail -n5 | awk '{print $10}'> main_help.log
echo "" >> main.log
cat main_help.log | tr '\n' ' ' >> main.log

sleep 30
done