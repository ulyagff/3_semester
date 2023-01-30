#!/bin/bash

fileName="$1"
trashDir=~/.trash
trashLogFile=~/.trash.log

if [[ ! -d "$trashDir" ]]; 
then
    echo "trash dir is not found"
    exit 1
fi


if [[ ! -f "$trashLogFile" ]]; 
then
    echo "trash log file is not found"
    exit 1
fi

fileNameReal=$(realpath $fileName)
grep -- "$fileNameReal" "$trashLogFile" | while read line; 
do
    echo "$line Restore? [y/n]"
    read ans < /dev/tty

    if [[ "$ans" = "y" ]] 
    then
        pathToRestore=$(echo "$line" | awk '{print $1}')
        path=$(echo "$pathToRestore" | sed 's/"$fileName"//')
        pathTrash=$(echo "$line" | awk '{print $2}')
        echo $pathToRestore $pathTrash

        if [[ -f "$pathToRestore" ]]; 
        then
            echo "file exists at the original path, it will be restored at HOME directory"
            pathToRestore="$HOME/$fileNameAbs"
        fi

        ln "$pathTrash" "$pathToRestore"

        while [[ "$?" != 0  ]];
        do
            echo "Enter new file name, file with this restoring name already exists"
            read $newName
            path="$path/$newName"
            ln "$trashFile" "$path"
        done
        rm "$pathTrash"
    fi


done