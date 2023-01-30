#!/bin/bash
echo -e "выберите действие:\n1-запуск nano\n2-запуск vim\n3-запуск браузера links\n4-выход из меню\n"
read choice

case "$choice" in
"1" )
nano;;
"2" )
vi;;
"3" )
links;;
"4" )
exit;;
esac