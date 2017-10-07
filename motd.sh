#!/bin/bash
  
date=`date "+%F %T"`
head="System Time: $date"
  
kernel=`uname -r`
hostname=`echo $HOSTNAME`
  
#Cpu load
load1=`cat /proc/loadavg | awk '{print $1}'`
load5=`cat /proc/loadavg | awk '{print $2}'`
load15=`cat /proc/loadavg | awk '{print $3}'`
  
#System uptime
uptime=`cat /proc/uptime | cut -f1 -d.`
upDays=$((uptime/60/60/24))
upHours=$((uptime/60/60%24))
upMins=$((uptime/60%60))
upSecs=$((uptime%60))
up_lastime=`date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S"`
  
#Memory Usage
mem_usage=`free -m | awk '/Mem:/{total=$2} /buffers\/cache/ {used=$3} END {printf("%3.2f%%",used/total*100)}'`
swap_usage=`free -m | awk '/Swap/{printf "%.2f%",$3/$2*100}'`
  
#Processes
processes=`ps aux | wc -l`
  
#User
users=`users | wc -w`
USER=`whoami`
  
#System fs usage
Filesystem=$(df -h | awk '/^\/dev/{print $6}')
  
#Interfaces
INTERFACES=$(ip -4 ad | grep 'state ' | awk -F":" '!/^[0-9]*: ?lo/ {print $2}')
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "\033[1;36m
 ██████╗ ███████╗███████╗██╗  ██╗ ██████╗██╗      ██████╗ ██╗   ██╗██████╗ 
██╔════╝ ██╔════╝██╔════╝██║ ██╔╝██╔════╝██║     ██╔═══██╗██║   ██║██╔══██╗
██║  ███╗█████╗  █████╗  █████╔╝ ██║     ██║     ██║   ██║██║   ██║██║  ██║
██║   ██║██╔══╝  ██╔══╝  ██╔═██╗ ██║     ██║     ██║   ██║██║   ██║██║  ██║
╚██████╔╝███████╗███████╗██║  ██╗╚██████╗███████╗╚██████╔╝╚██████╔╝██████╔╝
 ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝
\033[0m  "
echo
echo "$head"
echo "----------------------------------------------"
printf "Kernel Version:\t%s\n" $kernel
printf "HostName:\t%s\n" $hostname
printf "System Load:\t%s %s %s\n" $load1, $load5, $load15
printf "System Uptime:\t%s "days" %s "hours" %s "min" %s "sec"\n" $upDays $upHours $upMins $upSecs
printf "Memory Usage:\t%s\t\t\tSwap Usage:\t%s\n" $mem_usage $swap_usage
printf "Login Users:\t%s\nUser:\t\t%s\n" $users $USER
printf "Processes:\t%s\n" $processes
echo  "---------------------------------------------"
printf "Filesystem\tUsage\n"
for f in $Filesystem
do
    Usage=$(df -h | awk '{if($NF=="'''$f'''") print $5}')
    echo -e "$f\t\t$Usage"
done
printf "\n"
printf "Interface\tMAC Address\t\tIP Address\n"
for i in $INTERFACES
do
    MAC=$(ip ad show dev $i | grep "link/ether" | awk '{print $2}')
    IP=$(ip ad show dev $i | awk '/inet / {print $2}')
    printf $i"\t\t"$MAC"\t$IP\n"
done
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
