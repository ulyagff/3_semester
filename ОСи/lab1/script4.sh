#!/bin/bash

if [[ "$PWD" = "$HOME" ]]
then
echo "$HOME"
exit 0
else
echo "ERROR" 1>&2
exit
fi
