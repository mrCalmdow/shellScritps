#! /bin/sh
CONTAINERID=()

list(){
  echo "list container id :"
  #CONTAINERID=`docker ps -a | awk '{print $1}''`
  CONTAINERID=`docker ps -a | sed '1d' | awk '{print $1}'`
  for TMP in ${CONTAINERID[*]}
  do
    echo $TMP
  done
  #echo $CONTAINERID
}

clean(){
  #matching record 
  #echo "clean all container when status EXIT:"
  #for TMP in `docker ps -a | sed '1d' | awk '{if($7~/^Exit/)print $1}'`
  #do
  #  #echo $TMP
  #  echo `docker rm $TMP`
  #done
  
  #matching record when status include Exited and ago
  for TMP in `docker ps -a | sed '1d' | awk '{if($0~/Exit.*ago/)print $1}'`
  do
    echo `docker rm $TMP`
  done
}

case "$1" in
list)
list
;;
clean)
clean
;;
*)
printf 'Usage: %s {list|clean|**}\n' "$prog"
exit 1
;;
esac
