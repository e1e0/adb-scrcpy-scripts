# adb-scrcpy-scripts
Bash scripts for Android screen control in a Linux Deploy "chroot".

With code saved in folder "~/adb-scrcpy-scripts"...

## Copy file to Termux [shortcuts](https://github.com/termux/termux-widget#readme), set permissions

File "TERMUX_**STOP**_scrcpy_in_Linux_script.sh":

 1. `... platform-tools/adb push ~/adb-scrcpy-scripts/TERMUX_STOP_scrcpy_in_Linux_script.sh /sdcard/TERMUX_STOP_scrcpy_in_Linux_script.sh`
 2. https://wiki.termux.com/wiki/Internal_and_external_storage
 3. Termux: `mv ~/storage/shared/TERMUX_STOP_scrcpy_in_Linux_script.sh ~/.shortcuts/TERMUX_STOP_scrcpy_in_Linux_script.sh`
 4. Termux: `chmod +rwx ~/.shortcuts/TERMUX_STOP_scrcpy_in_Linux_script.sh`

and do that for "TERMUX_scrcpy_in_Linux_script.sh".

## Adding `adb` and `scrcpy` to a Linux Deploy container
(profile: "linux", GUI + X11 subsystem + Mounts enabled in "Properties" - new mounts: "/system/" > "/system/",  
"/sdcard/" > "/sdcard/", `mkdir /data/local/mnt/etc/` if it doesn't exist, update Settings > PATH variable  
"/system/xbin", https://github.com/meefik/linuxdeploy#faq)

```bash
... platform-tools/adb shell                                           # remote device shell
  su                                                                     # root login
    /data/data/ru.meefik.linuxdeploy/files/bin/linuxdeploy -p linux shell  # container root login
      uname -m                                                               # the machine hardware name
      exit
    exit
  exit
```
**If** the machine hardware is "x86_64": https://developer.android.com/studio/releases/platform-tools#downloads,  
copy that "platform-tools" folder to `$HOME`, `... platform-tools/adb push ~/platform-tools /sdcard/platform-tools`

 1. `... platform-tools/adb push ~/adb-scrcpy-scripts/add_to_container.sh /sdcard/add_to_container.sh`
 2. `... platform-tools/adb shell`
 3. `su --command "mv /sdcard/add_to_container.sh ~/ && { . ~/add_to_container.sh '`\[that hardware name]`' && rm ~/add_to_container.sh; }"`

## Executing `adb` and `scrcpy`

(Properties -> mounts has /sdcard/" > "/sdcard/")

```bash
...
      exit
    exit
$ exit
... platform-tools/adb push ~/adb-scrcpy-scripts/LINUX_CONTAINER/ /sdcard/LINUX_CONTAINER/
... platform-tools/adb shell                                           # remote device shell
  su                                                                     # root login
    /data/data/ru.meefik.linuxdeploy/files/bin/linuxdeploy -p linux shell  # container root login
      sudo -u android bash -c 'mv /sdcard/LINUX_CONTAINER/ ~/Desktop/'
      readarray -t files <<<"$(ls /home/android/Desktop/LINUX_CONTAINER/ | sed -E '/.+\.[^s][^h].*/d')";\
        declare -p files;
      for (( i=0 ; i < ${#files[*]} ; ++i )); do chmod u+x "/home/android/Desktop/LINUX_CONTAINER/${files[$i]}"; \
        /bin/chown android "/home/android/Desktop/LINUX_CONTAINER/${files[$i]}"; done
      exit
    exit
  exit
```

Login to container in ~~VNC~~ X11 (Linux Deploy -> "START", XServer XSDL), run ~/Desktop/**LINUX_CONTAINER/execute_adb_scrcpy.sh**...