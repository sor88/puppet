#!/bin/bash
apt-get install puppet > .log.log &
(
i="0"
while (true)
do
proc=$(ps aux | grep -v grep | grep -e "apt-get")
if [[ "$proc" == "" ]]; then break; fi
sleep 1
echo $i
i=$(expr $i + 2)
done;
echo 100
sleep 5
) | whiptail --title "TEST" --gauge "Please wait" 7 70 10



##!/bin/bash
#{
#    for ((i = 0 ; i <= 100 ; i+=20)); do
#        sleep 1
#        echo $i
#    done
#} | whiptail --gauge "Please wait while installing" 6 60 0
rm .log.log
