#! /usr/bin/bash

echo -e "\
adb-scrcpy-scripts: Bash scripts for Android screen\n\
  control in a Linux Deploy \"chroot\" container.\n\
   Copyright (c) 2022 Edward \"philosophical\" J\n\
     (https://github.com/e1e0) - MIT License."

read -e -i "192.168.[num.num]" -p "device IP address: "
echo "Connecting to \"$REPLY\"..."; adb connect $REPLY

i=0
while (($i < 2)); do
  if [[ $(adb devices | grep 'device$') != "" ]]; then
    declare -x SDL_VIDEODRIVER='x11'
    scrcpy --render-driver=software
    break
  else
    echo "\nCan't connect! :-("
    adb reconnect offline
    sleep 10s
    i+=1
  fi
done