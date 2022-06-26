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
(profile: "linux", GUI + X11 subsystem + Mounts enabled in "Properties" - mounts: "/system/" > "/system/",  
`mkdir /data/local/mnt/etc/` if it doesn't exist, update Settings > PATH variable "/system/xbin", https://github.com/meefik/linuxdeploy#faq)

```bash
... platform-tools/adb shell                                           # remote device shell
  su                                                                     # root login
    /data/data/ru.meefik.linuxdeploy/files/bin/linuxdeploy -p linux shell  # container root login
      uname -m                                                               # the machine hardware name
```

Properties -> mounts -> + new "/sdcard/" > "/sdcard/".

 - **"x86_64" machine hardware:** https://developer.android.com/studio/releases/platform-tools#downloads,  
   `cp -R` the folder in "/sdcard/".

 - **"aarch64" machine hardware:**
   - [`apt-get`](https://opensource.com/article/18/8/how-install-software-linux-command-line)` install android-sdk-platform-tools`
   - or do https://github.com/thejunkjon/android-tools (`cp -R` it from "/sdcard/").

### `scrcpy`:

Go to https://github.com/Genymobile/scrcpy#linux or ("aarch64" machine) https://github.com/Genymobile/scrcpy/blob/master/BUILD.md#simple,  
`nano ./install_release.sh` -> "--check" to "-c", replace BusyBox package with apt package:

```bash
      exit # device shell
    mount -o rw,remount /system 2>/dev/null || mount -o rw,remount / 2>/dev/null
    rm /system/xbin/ar
    /data/data/ru.meefik.linuxdeploy/files/bin/linuxdeploy -p linux shell
      apt-get install --reinstall binutils
      cd scrcpy
```

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

Login to container in ~~VNC~~ X11 (Linux Deploy -> "START", XServer XSDL), run ~/Desktop/**LINUX_CONTAINER_execute_adb_scrcpy.sh**...