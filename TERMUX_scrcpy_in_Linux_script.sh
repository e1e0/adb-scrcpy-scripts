#! /data/data/com.termux/files/usr/bin/bash

command='start -m'
if [[ $1 == 'STOP' ]]; then
  command='stop -u'
fi

su -c "/data/data/ru.meefik.linuxdeploy/files/bin/linuxdeploy -p linux $command"
