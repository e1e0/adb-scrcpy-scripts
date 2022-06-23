#! /usr/bin/bash

read -p "device IP address: " -i "192.168.[num.num]"

echo "Connecting to \"$REPLY\"..."

if [[ adb connect $REPLY ]]; then
  scrcpy
else
  echo "Can't connect!"
fi
