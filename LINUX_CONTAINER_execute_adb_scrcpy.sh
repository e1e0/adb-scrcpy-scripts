#! /usr/bin/bash

echo -e "\
adb-scrcpy-scripts: Bash scripts for Android screen\n\
  control in a Linux Deploy \"chroot\" container.\n\
   Copyright (c) 2022 Edward \"philosophical\" J\n\
     (https://github.com/e1e0) - MIT License."

read -e -i "192.168.[num.num]" -p "device IP address: "

declare -x SDL_VIDEODRIVER='x11'
echo "Connecting to \"$REPLY\"..."

if ( adb connect $REPLY ); then
  scrcpy --render-driver=software
else
  echo "Can't connect! 🙁"
  sleep 3s
fi
