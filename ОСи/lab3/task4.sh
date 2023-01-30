bash ./loop.sh &
pid1=$!
bash ./loop.sh &
pid2=$!
bash ./loop.sh &
pid3=$!


echo "$pid3"
dx=0

while true
do

cpu=$(top -b -n1 -p $pid1 | tail -n1 | awk '{printf("%u",$9)}')
if [[ "$cpu" -gt 10 ]]
then
renice -n $dx -p $pid1
let dx++
fi

done 