#! /bin/sh

if [ -z `ps -ef | grep consul | grep agent | awk '{print $3}'` ];then
  echo "have no consul pid"
else
  echo `ps -ef | grep consul | grep agent | awk '{print $3}'`  
fi
