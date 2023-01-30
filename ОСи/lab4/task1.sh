#!/bin/bash
read -r fileNameAbs
trashDir=~/.trash
trashLogFile=~/.trash.log


if [[ ! -f "$fileNameAbs" ]]; 
then
    echo "$fileNameAbs не существует или это директория"
    exit 1
fi

if [[ ! -d "$trashDir" ]]; 
then
    mkdir $trashDir
fi


if [[ ! -f "$trashLogFile" ]]; 
then
    touch $trashLogFile
fi

ln "$fileNameAbs" "$trashDir/$(date '+%d-%m-%Y_%H:%M:%S')"
rm "$fileNameAbs"

echo $(realpath $fileNameAbs) "$trashDir/$(date '+%d-%m-%Y_%H:%M:%S')" >> $trashLogFile

