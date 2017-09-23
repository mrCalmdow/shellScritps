#! /bin/sh
SOURCE_DIR=""
DIST_DIR=""
JARS=()
archive(){
  echo start archive jars.
  echo $SOURCE_DIR -- $DIST_DIR
  if [ -d $SOURCE_DIR ]; then
    if [ -d $DIST_DIR ]; then
      for JARNAME in `find $SOURCE_DIR -name *.jar`
      do
        echo $JARNAME
        #cp -f $JARNAME /Users/feilongchen/fuyhui_ci/jars/
        cp -f $JARNAME $DIST_DIR
      done
    fi
  fi
}

test(){
  echo you run test.
  #JARS=`find /Users/feilongchen/.jenkins/workspace/local_ci -name *.jar`
  for JARNAME in `find $SOURCE_DIR  -name *.jar`
  do
    echo $JARNAME : $SOURCE_DIR -  $DIST_DIR
  done 
}

##########################
#if $# -gt 2
if [ $# -lt 3 ]; then
  echo "Should be input a directory to search jar file. and dist directory"
  echo $# arg has input.
  exit
fi
SOURCE_DIR=$2
DIST_DIR=$3

case "$1" in
test)
test
;;
archive)
archive
;;
*)
printf 'Usage %s { archive | test }\n'
esac
