#!/bin/bash
#trap 'echo "# $BASH_COMMAND";read' DEBUG
declare -a startBytes

for pid in $(ps -e --format="pid" | sed '1d')
do
    io_file="/proc/$pid/io"
    buffer=$(grep read_bytes $io_file| grep -o "[0-9]\+")
    startBytes[$pid]=$buffer
done 2> /dev/null

sleep 10

declare -a finishBytes

for pid in $(ps -e --format="pid" | sed '1d')
do
    io_file="/proc/$pid/io"
    buffer=$(grep read_bytes $io_file | grep -o "[0-9]\+")
    finishBytes[$pid]=$buffer
done 2> /dev/null

for i in ${!finishBytes[@]};
do
start=${startBytes[$i]}
finish=${finishBytes[$i]}

if [[ "$start" == "" ]]
then start=0
fi

let 'difference=finish-start'
echo "$difference $i"
done 1> tmp

cat tmp | sort -n | tail -n 3 | awk '{
cmd="ps ax | grep "$2" | awk \47{print $5}\47"
cmd | getline ex_line
printf "%s:%s:%s\n", $2, ex_line, $1
}'
rm tmp