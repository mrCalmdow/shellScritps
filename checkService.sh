#! /bin/sh

#ll | grep -n jar$ | grep -v common | awk '{print $9}'
#ps -ef | grep java | grep fuy | awk '{print $10}'

ALLJARS=()
ALLSERVERS=()
INDEX=0
ALLJARSNUM=`ls -l | grep -n jar$ | grep -v common | awk '{print $9}' | wc -l`
ALLSERVERSNUM=`ps -ef | grep java | grep fuy | awk '{print $10}' | wc -l`

echo ALLSERVERSNUM $ALLSERVERSNUM
echo ALLJARSNUM $ALLJARSNUM

#array can get values like this
ALLJARS=`ls -l | grep -n jar$ | grep -v common | awk '{print $9}'`
ALLSERVERS=`ps -ef | grep java | grep fuy | awk '{print $10}'`

#itertor jars and servers check who has not start
for TMPJAR in $ALLJARS
do
  let FLAG=0
  for TMPSERVER in $ALLSERVERS
  do
    if [ "$TMPJAR"x = "$TMPSERVER"x ];then
      let FLAG=1
      break
    fi 
  done
  #if flag still 0 not find
  if [ "$FLAG" -eq "0" ];then
    echo $TMPJAR not start.
  fi
done

ALLJARSNUM=`ls -l | grep -n jar$ | grep -v common | awk '{print $9}' | wc -l`
ALLSERVERSNUM=`ps -ef | grep java | grep fuy | awk '{print $10}' | wc -l`
if [ "$ALLJARSNUM" -gt "$ALLSERVERSNUM" ];then
  echo start not fully.
  exit 1
fi
