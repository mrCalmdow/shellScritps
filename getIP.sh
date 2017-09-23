#! /bin/sh

IPADDR=''

echo `ifconfig | grep 192.168. | awk '{print $2}'`

IPADDR=`ifconfig | grep 192.168. | awk '{print $2}'`
echo $IPADDR
