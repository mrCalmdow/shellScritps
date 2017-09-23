#! /bin/sh
# ********************************************************
# *Author		: flchen
# *Email		: 634233816@qq.com
# *Create time	: 2017-09-23 11:27
# *Modify time	: 2017-09-23 11:27
# *FileName		: test.sh
# ********************************************************
INDEX=0
JARSNAME=()
PARAS=()
PINDEX=0
PNUM=0

test() {
	result=`check_command_md5`
	if [ $result = "1" ]; then
		echo "no md5sum"
	else
		echo "command ok"
	fi
	#echo ${PARAS[1]}
	#echo `ls ${PRARS[1]} | grep jar$`
	#generate_md5_file "aaaa"
}

createMD5() {
	#create md5 file for every one
	#查询指定的目录
	for JARNAME in `ls ${PARAS[1]} | grep jar$`
	do
		echo "---Prepare to generate " $JARNAME
		JARSNAME[INDEX]=$JARNAME
		result=`check_command_md5sum`
		#echo "------1---------" &result
		if [ $result = "1" ]; then
			result=`check_command_md5`
			#echo "------2---------" &result
			if [ $result = "1" ]; then
				echo "can't create md5 file. beacuse you have no \"md5sum\" and \"md5\" command."
				break
			elif [ $result = "0" ]; then
				#使用md5命令生成
				echo "invoke md5====="$JARNAME
				generate_md5_file "md5" $JARNAME
			fi
		elif [ $result = "0"]; then
			#使用md5sum命令生成
			echo "invoke md5sum===="$JARNAME
			generate_md5_file "md5sum" $JARNAME
		fi
		let INDEX=INDEX+1
		echo "---Generate"$JARNAME".md5 succeed."
	done


}

#检查系统是否有md5sum命令可用
check_command_md5sum(){
	man md5sum >/dev/null 2>&1
	echo $?
}
#检查系统是否有md5命令可用
check_command_md5(){
	man md5 >/dev/null 2>&1
	echo $?
}

#执行生成MD5文件动作
generate_md5_file(){
	echo "generate!"
	if [ -d ${PARAS[1]} ]; then
		#echo ${PARAS[1]}
		echo "touch a file to ---->" ${PARAS[1]} "fileName: ----> " "$2"
		touch ${PARAS[1]}/"$2".md5
		if [ "$1" = "md5" ]; then
			echo "Point to use command \"md5\""
			#MD5 (updatedemo-0.0.1-SNAPSHOT.jar) = 8f6e3dc524d079538cd6305037d27059
			md5 ${PARAS[1]}/"$2" | awk '{print $4}' > ${PARAS[1]}/"$2".md5
		elif [ "$1" = "md5sum" ]; then
			#echo "Point to use command \"md5sum\""
			#md5的结果格式为
			#8f6e3dc524d079538cd6305037d27059  updatedemo-0.0.1-SNAPSHOT.jar
			md5sum ${PARAS[1]}/"$2" | awk '{print $1}' > ${PARAS[1]}/"$2".md5
		else
			echo "Unidentifiable command---------"
			exit 1
		fi
	fi
}

#打印执行时的参数----到了函数里面就失效了
print_parameters(){
	for PARA in $@
	do
		echo $PARA
	done
}

##############################
#判断执行此脚本时带的参数个数
if [ $# -ne 2 ]; then
	echo "Please input tow parameters."
	if [ $# -le 2 ]; then
		echo "parameters too less."
	elif [ $# -gt 2]; then
		echo "parameters too more."
	fi
fi
#循环获取每个入参
let PNUM=$#
for PARA in $@
do
	PARAS[PINDEX]=$PARA
	#echo $PARA
	echo $PINDEX "-->" ${PARAS[PINDEX]}
	let PINDEX=PINDEX+1
done

#############################
case "$1" in
create)
createMD5
;;
test)
test
;;
*)
printf 'Usage: %s { createMD5 \"filepath\" }\n' "$prog"
exit 1
;;
esac
exit 0
