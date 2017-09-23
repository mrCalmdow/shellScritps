#! /bin/sh

PNUM=0
PARAARRA=()
INDEX=0
JARSNAME=()
##############################################
test(){
  echo test
}

startAll(){
  NOW=`date "+%Y%m%d%H%M%S"`
  for JARNAME in `ls | grep jar$`
  do
    echo start jar : $JARNAME
    exec java -jar $JARNAME > $JARNAME$NOW.log &
    sleep 20
  done
}

start(){
  NOW=`date "+%Y%m%d%H%M%S"`
  let INDEX=INDEX-1
  while [ $INDEX -gt 0 ]
  do
    echo "start" ${PARAARRA[INDEX]}
    TMP=${PARAARRA[INDEX]}
    #echo $TMP
    TMP=`ls -l | grep "${TMP}" | awk '{print $9}'`
    exec java -jar $TMP > $TMP$NOW.log &
    sleep 20
    let INDEX=INDEX-1
  done
}

stopAll(){
  for TMPPID in `ps -ef | grep fuyhui- | awk '{print $2}'`
  do
    echo kill : $TMPPID
    kill $TMPPID
  done
  #rm packges
  sleep 5
  for FILE in `ls | grep fuyhui-`
  do
    rm -rf /opt/fyh_remotedir/runable/"${FILE}"
  done
}

stop(){
  let INDEX=INDEX-1
  if [ $INDEX -gt 1 ]
  then
    while [ $INDEX -gt 0 ]
    do
      echo "stop service : " ${PARAARRA[INDEX]}
      TMP=${PARAARRA[INDEX]}
      #TMP=`ps -ef | grep "${TMP}" | awk '{print $2}'`
      #echo stop $TMP
      #kill $TMP
      TMPPID=`ps -ef | grep "${TMP}" | awk '{print $2}' | sed -n '1p'`
      echo stop $TMPPID
      sleep 1
      kill $TMPPID
      let INDEX=INDEX-1
    done
    #rm packges
    for FILE in `ls | grep "${TMP}"`
    do
      rm /opt/fyh_remotedir/runable/"${FILE}"
    done
  else
    echo "You need point to stop who."
  fi
}

##############################################
if [ $# -lt 1 ]; then
  echo "please input parameters"
  exit
  echo "should be quit already"
fi

let PNUM=$#

for PARA in $@
do
  PARAARRA[INDEX]=$PARA
  #echo ${PARARRA[INDEX]}
  let INDEX=INDEX+1
done

case "$1" in
test)
test
;;
startAll)
startAll
;;
start)
start
;;
stop)
stop
;;
stopAll)
stopAll
;;
restart)
stop
sleep 5
start
;;
*)
printf 'Usage: %s {test | start | stop | restart }\n' "$prog"
exit 1
;;
esac
