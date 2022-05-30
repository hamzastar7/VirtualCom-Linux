#!/bin/bash
# use like: sudo ./COM_Server <Port_number> <Number_COM>
#you should have insttaled the nmap package
#alll the commands are runing in background you can always change the directory of the virtual port


###if you run this script twice in the same Port you will have an error so uncomant thies to kill the previouse script
#killall nc 2>/dev/null
#killall socat 2>/dev/null
#killall ncat 2>/dev/null

if [ $# -eq  2 ]
        then
        PORT=$1
        COMNUM=$2

fi

if [[ $# -eq 1 ]]; then
	
        echo "Please Enter COM number like ttyS**   ex: 12  for ttyS12"
        read COMNUM
	PORT=$1
fi
if [ $# -eq 0 ];then
	echo "Please Enter your port:"
	read PORT
        echo "Please Enter COM number like ttyS**   ex: 55  for ttyS55"
        read COMNUM

fi
VIRTUAL_TERMINAL="/tmp/ttyVirtualCom$COMNUM"

ncat --broke --listen -p $PORT &

sleep 2
socat pty,link=/tmp/ttyVirtualCom$COMNUM,echo=0 tcp:localhost:$PORT&
echo "a virtual serial port was created in: /dev/ttyS$COMNUM"

ln -s /tmp/ttyVirtualCom$COMNUM /dev/ttyS$COMNUM

echo " your ip address is $(ip address |grep inet |grep brd|awk '{print $2}')"
echo "with th port :   $PORT"
