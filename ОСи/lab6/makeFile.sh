#!/bin/bash
name="./files/$1"
for ((i=2; i<2000; i++))
do
echo -n "12345678" >> "$name"
done