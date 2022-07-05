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

## `adb` and `scrcpy` in a Linux Deploy container

(profile: "linux", Mounts + GUI + X11 subsystem enabled in "Properties" **-> new mounts**: "/system/xbin/" > "/system/xbin/",
"/data/local/tmp/" > "/data-tmp/", "/sdcard/" > "/sdcard/", update Settings > PATH variable "/system/xbin",  
https://github.com/meefik/linuxdeploy#faq, `mkdir /data/local/mnt/etc/` if it doesn't exist)

```bash
... platform-tools/adb shell                                           # remote device shell
  su                                                                     # root login
    /data/data/ru.meefik.linuxdeploy/files/bin/linuxdeploy -p linux shell  # container root login
      uname -m                                                               # the machine hardware name
      exit

    # If hardware name is "aarch64", replace BusyBox package with apt package:
    mount -o rw,remount /system 2>/dev/null || mount -o rw,remount / 2>/dev/null
    rm /system/xbin/ar

    exit
  exit
```
**If** the machine hardware is "x86_64": https://developer.android.com/studio/releases/platform-tools#downloads,  
copy that "platform-tools" folder to `$HOME`, `... platform-tools/adb push ~/platform-tools /sdcard/platform-tools`

 1. `... platform-tools/adb push ~/adb-scrcpy-scripts/add_to_container.sh /sdcard/add_to_container.sh`
 2. `... platform-tools/adb shell`
 3. `su --command "cat /sdcard/add_to_container.sh > /data/local/tmp/add_to_container.sh && /data/data/ru.meefik.linuxdeploy/files/bin/linuxdeploy -p linux shell"`
    - `bash -c ". /data-tmp/add_to_container.sh `\[that hardware name]`"`
    - `exit`
 4. `su --command "rm /data/local/tmp/add_to_container.sh"`

```bash
...
$ exit
... platform-tools/adb push ~/adb-scrcpy-scripts/LINUX_CONTAINER/ /sdcard/
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

### Executing

Login to container in ~~VNC~~ X11 (Linux Deploy -> "START", XServer XSDL), run (~/Desktop/)**LINUX_CONTAINER/execute_adb_scrcpy.sh**...