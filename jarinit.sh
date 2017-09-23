#! /bin/sh    
JARSPID=()
PIDINDEX=0
JARSNAME=()
INDEX=0

#启动方法
start(){
  now=`date "+%Y%m%d%H%M%S"`
  #exec java -Xms128m -Xmx2048m -jar /opt/fyh_remotedir/jars/fuyhui-zuul-1.0-SNAPSHOT.jar>"$now"_bidcheck.log &
  for JARNAME in `ls | grep jar$`
  do
    echo $JARNAME
    JARSNAME[INDEX]=$JARNAME
    let INDEX=INDEX+1
  done

  for TMP in ${JARSNAME[*]}
  do
    echo start jar: $TMP
    exec java -jar $TMP > $TMP.log &
    sleep 20
  done
}   
#停止方法    
stop(){   
  for TMPPID in `ps -ef | grep fuyhui- | awk '{print $2}'` 
  do
    echo kill : $TMPPID
    kill $TMPPID
    #kill -9 $TMPPID
    sleep 2
  done

  #TMP_PID=`ps -ef | grep fuyhui | awk '{print $2}' | sed -n '1p'`
  #while [ -n "$TMP_PID" ]
  #do
  #kill -9 "$TMP_PID"
  #TMP_PID=`ps -ef | grep fuyhui | awk '{print $2}' | sed -n '1p'`
  #echo $TMP_PID
  #done
}

test(){
  #TMP_PID=`ps -ef | grep fuyhui | awk '{print $2}' | sed -n '1p'`
  #while [ -n "$TMP_PID" ]
  #do
  #kill -9 "$TMP_PID" 
  #TMP_PID=`ps -ef | grep java | awk '{print $2}' | sed -n '1p'`
  #echo $TMP_PID
  #sleep 2
  #done
  
  #ARR_JARS=`ls | grep jar$`  
  #for TMP in ${ARR_JARS[*]}
  #do
  #  echo $TMP
  #done

  for JARNAME in `ls | grep jar$`
  do
    echo $JARNAME
    JARSNAME[INDEX]=$JARNAME
    let INDEX=INDEX+1
  done

  for TMP in ${JARSNAME[*]}
  do
    echo start jar: $TMP
    exec java -jar $TMP > $TMP.log &
    sleep 20
  done
}
    
case "$1" in
test)
test
;;
start)
start
;;
stop)
stop
;;
restart)
stop
sleep 5
start
;; 
*)
printf 'Usage: %s {start|stop|restart}\n' "$prog"
exit 1
;;
esac
