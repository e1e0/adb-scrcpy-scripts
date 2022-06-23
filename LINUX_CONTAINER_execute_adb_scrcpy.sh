#! /usr/bin/bash

read -e -i "192.168.[num.num]" -p "device IP address: "

echo "Connecting to \"$REPLY\"..."

if ( adb connect $REPLY ); then
  scrcpy
else
  echo "Can't connect! 🙁"
fi
