#!/bin/bash

ps U root | sed '1d' | wc -l > countUserRoot.txt
ps -e --format="pid cmd" | awk '{print $1 ":" $2}' >> countUserRoot.txt
sed '2d' countUserRoot.txt > out1.log
rm countUserRoot.txt