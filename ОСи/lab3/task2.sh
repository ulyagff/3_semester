#!/bin/bash
at -f task1.sh now+2m


( tail -n0 -f ~/report ) |
while read LINE; do

    echo $LINE

done