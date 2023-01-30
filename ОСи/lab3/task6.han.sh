#!/bin/bash
echo $$ > .pid

result=1
operation="-"

usr1() {
    operation="+"
}

usr2() {
    operation="*"
}

term() {
    operation="stop"
}

trap 'usr1' USR1
trap 'usr2' USR2
trap 'term' SIGTERM

while true
do
case $operation in
"+")
let result+=2
echo $result
;;
"*")
let result*=2
echo $result

;;
"stop")
echo "stopped by SIGTERM"
exit 0
;;
-)
:
;;
esac
sleep 1
done
