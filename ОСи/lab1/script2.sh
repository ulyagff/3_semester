#!/bin/bash

str=""
read tempstr
while [[ "$tempstr" != "q" ]]
do
    str+="${tempstr}"
    read tempstr
done

echo "$str"