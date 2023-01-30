#!/bin/bash

path=~
previousBackup=$(ls $path | grep -E "Backup-[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}" | sort -n | tail -n1)

[ -z $previousBackup ] && { echo "Previous backup absent"; exit 1; }
[ -d "$path/restore" ] && rm -r $path/restore/* || mkdir $path/restore

for file in $(ls $path/$previousBackup | grep -Ev "\.[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}$"); do
    echo "$file"
    cp -- "$path/$previousBackup/"$file"" "$path/restore/"
done