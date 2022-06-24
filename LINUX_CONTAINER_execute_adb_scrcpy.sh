#! /usr/bin/bash

echo -e "\
adb-scrcpy-scripts: Bash scripts for Android screen\n\
  control in a Linux Deploy \"chroot\" container.\n\
   Copyright (c) 2022 Edward \"philosophical\" J\n\
     (https://github.com/e1e0) - MIT License."

read -e -i "192.168.[num.num]" -p "device IP address: "

echo "Connecting to \"$REPLY\"..."
adb connect $REPLY

if [[ $(adb devices | grep 'unauthorized') == "" ]]; then
  declare -x SDL_VIDEODRIVER='x11'
  scrcpy --render-driver=software
else
  echo "Can't connect! \U1F641"
  adb reconnect offline
  sleep 12s
  declare -x SDL_VIDEODRIVER='x11'
  scrcpy --render-driver=software
fi
