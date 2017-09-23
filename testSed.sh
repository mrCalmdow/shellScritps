#! /bin/sh
IPADDR=''
IPADDR=`ifconfig | grep 192.168. | awk '{print $2}'`
sed -ig "s/121.201.15.67:6699/$IPADDR:1200/" hello.txt
