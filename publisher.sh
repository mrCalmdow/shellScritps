NS_TRANSFER_FOLDER="/opt/jenkisRemoteDir"
TOMCAT_PORT=8080
PROJECT="$1"
################################################################
source /etc/profile
#param validate
echo "------------------------------------start param validate------------------------------------------------------------------------------"
if [ $# -lt 1 ]; then
  echo "you must use like this : ./publish.sh <projectname> [tomcat port] [tomcat home dir]"  
  exit
fi
if [ "$1" != "" ]; then
	PROJECT="$1"
else
	PROJECT="ArtifactID"
fi
if [ "$2" != "" ]; then
   TOMCAT_PORT=$2
fi
if [ "$3" != "" ]; then
   TOMCAT_HOME="$3"
   rm -rf $TOMCAT_HOME/webapps/$PROJECT*
else
   TOMCAT_HOME="/opt/tomcat/tomcat8080"
   rm -rf $TOMCAT_HOME/webapps/$PROJECT*
fi
echo "params : "$1,$2,$3
echo "------------------------------------end param validate------------------------------------------------------------------------------"
###############################################################
#shutdown tomcat
echo "------------------------------------start shutdown tomcat first------------------------------------------------------------------------------"
#check tomcat process
tomcat_pid=`lsof -n -P -t -i :$TOMCAT_PORT`
echo "current :" "$tomcat_pid"
while [ -n "$tomcat_pid" ]
do
	"$TOMCAT_HOME"/bin/shutdown.sh
	sleep 2
	tomcat_pid=`lsof -n -P -t -i :$TOMCAT_PORT`
	echo "---scan tomcat pid :" $tomcat_pid
	kill -9 `lsof -n -P -t -i :$TOMCAT_PORT`
	echo "Kill it ~~"
done
echo "tomcat had shutdown~~"
echo "------------------------------------end shutdown tomcat first------------------------------------------------------------------------------"

#################################################################
#publish project
echo "------------------------------------start publisher------------------------------------------------------------------------------"
echo $PROJECT" publishing~~~"
rm -rf "$TOMCAT_HOME"/webapps/$PROJECT*
sleep 2

echo "rm old package"
cp $NS_TRANSFER_FOLDER/$PROJECT.war "$TOMCAT_HOME"/webapps/$PROJECT.war
sleep 2
echo "copy OK~~~"
#bak project
BAK_DIR=$NS_TRANSFER_FOLDER/bak/$PROJECT/`date +%Y%m%d`
mkdir -p "$BAK_DIR"
cp "$TOMCAT_HOME"/webapps/$PROJECT.war "$BAK_DIR"/"$PROJECT"_`date +%H%M%S`.war
sleep 2
#remove tmp
rm -rf $NS_TRANSFER_FOLDER/$PROJECT*.war
sleep 1
echo "bakup & remove tmpFile OK~~~"
echo "------------------------------------end publisher------------------------------------------------------------------------------"
#start tomcat
$TOMCAT_HOME/bin/startup.sh
echo "------------------------------------start tomcat before publisher--------------------------------------------------------------"
