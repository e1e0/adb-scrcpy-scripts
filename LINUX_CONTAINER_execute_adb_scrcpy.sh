#! /usr/bin/bash

echo -e "\
adb-scrcpy-scripts: Bash scripts for Android screen\n\
  control in a Linux Deploy \"chroot\" container.\n\
   Copyright (c) 2022 Edward \"philosophical\" J\n\
     (https://github.com/e1e0) - MIT License.\n"

read -e -i "192.168.[num.num]" -p "device IP address: "
echo "Connecting to \"$REPLY\"..."; adb connect $REPLY

i=0
while (($i <= 2)); do
  if [[ $(adb devices | grep 'device$') != "" ]]; then
    declare -x SDL_VIDEODRIVER='x11'
    scrcpy --render-driver=software
    break
  else
    echo -e "\nCan't connect! :-("
    sleep 3s; echo "Re-connecting..."
    adb connect $REPLY
    i+=1
  fi
done
