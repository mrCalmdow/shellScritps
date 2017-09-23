#! /bin/sh

IPADDR=''

start(){
  if [ -z `ps -ef | grep consul | grep agent | awk '{print $3}'` ];then  
    echo clean data-dri
    rm -rf /Users/feilongchen/consul/data/*
    echo start consul...
    nohup /usr/local/Cellar/consul/0.8.4/bin/consul agent -ui -client 0.0.0.0 -advertise $IPADDR -data-dir /Users/feilongchen/consul/data -bootstrap -server > /Users/feilongchen/consul/logs/log.out 2>&1 &
    sleep 2
    echo consul has started.
  else
    echo consul has started on you service PID is `ps -ef | grep consul | grep agent | awk '{print $3}'`
  fi
}

stop(){
  echo stop consul...
  kill `ps -ef | grep consul | awk '{print $2}'`
  echo consul has been stoped.
  echo clean data...
  rm -rf /opt/consulData/*
  echo clean logs
  rm -rf /opt/consulLog/logs.out
  echo done.
}

test(){
 echo test
}

#############################################################
IPADDR=`ifconfig | grep 192.168. | awk '{print $2}'`

case "$1" in
  start)
  start
  ;;
  stop)
  stop
  ;;
  restart)
  stop
  start
  ;;
  restart)
  stop
  start
  ;;
  test)
  test
  ;;
  *)
  echo "Usage {start | stop | restart | test }"
  exit 1
  ;;
esac
