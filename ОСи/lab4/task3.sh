#!/bin/bash
function dateComparison()
{
    echo "$(($1 - $2))"
}

path=~
creationDate="$(date +"%F")"

lastBackup=$(ls $path | grep -E "Backup-[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}" | sort -n | tail -n1)
dateLastBackup=$(echo "$lastBackup" | sed -e "s/Backup-//")

dateOffset=$(dateComparison $(date -d "$creationDate" +'%s') $(date -d "$dateLastBackup" +'%s'))
dateOffset=$(($dateOffset/3600/24))
checkerCode=1

if [[ -z "$lastBackup" ]]; then
    newBackup="$path/Backup-$creationDate";
    mkdir $newBackup
    checkerCode="$?";
    echo "new Backup $newBackup was created" >> $path/backup-report
fi

dateOffset=${dateOffset/#-}

if [[ "$dateOffset" -gt 7 ]]; then
    newBackup="$path/Backup-$creationDate";
    mkdir $newBackup
    checkerCode="$?";
    echo "new Backup $newBackup was created" >> $path/backup-report
fi

[ -d "$path/source" ] || { echo "Directory source does not exist, please create one"; exit 1; }

if [[ "$checkerCode" -eq "0" ]]; then
        
        cp -r $path/source/* $newBackup
        if [[ "$?" -ne "0" ]]; then echo "Error occured during file copying"; exit 1; fi
        echo "added files: $(ls $newBackup)" >> $path/backup-report

else
        for file in $(ls $path/source); do

            if [[ -f $path/$lastBackup/$file ]]; then
                previousSize=$(wc -c $path/$lastBackup/$file | awk '{print $1}')
                currentSize=$(wc -c $path/source/$file | awk '{print $1}')

                    if [[ "$previousSize" != "$currentSize" ]]; then
                        newFileName="$file.$creationDate"
                        mv $path/$lastBackup/$file $path/$lastBackup/$newFileName
                        cp $path/source/$file $path/$lastBackup
                        echo "$newFileName $file" >> changedFiles.txt
                    fi
            else 
                if [[ -d $path/$lastBackup/$file ]]; then
                echo "system of backup works only with files. Conflict resolve is not possible for forders"
                else
                    cp $path/source/$file $path/$lastBackup
                    echo $file >> newFiles.txt
                fi
            fi
        done
    
    echo "directory was updated: $lastBackup" >> $path/backup-report
    
    [ -f newFiles.txt ] && { echo "new files: $(cat newFiles.txt)" >> $path/backup-report; }
    [ -f changedFiles.txt ] && { echo "changed files: $(cat changedFiles.txt)" >> $path/backup-report; }

    rm newFiles.txt changedFiles.txt > /dev/null
fi