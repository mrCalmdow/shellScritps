#! /bin/sh

start(){
  echo start consul...
  nohup /usr/local/consul/consul agent -data-dir /opt/consulData -ui -client 0.0.0.0 -bind=192.168.102.238 -advertise 192.168.102.238 -dev > /opt/consulLog/logs.out 2>&1 &
  sleep 2
  echo consul has started.
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
