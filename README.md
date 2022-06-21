# adb-scrcpy-scripts
Bash scripts for Android screen control in a Linux Deploy "chroot".

## adb - copy file to Termux [shortcuts](https://github.com/termux/termux-widget#readme), set permissions:

File "TERMUX_scrcpy_in_Linux_script.sh":

 1. `... platform-tools/adb push TERMUX_scrcpy_in_Linux_script.sh /sdcard/TERMUX_scrcpy_in_Linux_script.sh`
 2. https://wiki.termux.com/wiki/Internal_and_external_storage
 3. Termux: `mv ~/storage/shared/TERMUX_scrcpy_in_Linux_script.sh ~/.shortcuts/TERMUX_scrcpy_in_Linux_script.sh`
 4. Termux: `chmod +rwx ~/.shortcuts/TERMUX_scrcpy_in_Linux_script.sh`

## Adding `adb` and `scrcpy` to a Linux Deploy container
(profile: "linux")

```bash
       $ su
   ....# /data/data/ru.meefik.linuxdeploy/files/bin/linuxdeploy bin/linuxdeploy -p linux shell
root@... 
```




*adb + https://opensource.com/article/18/8/how-install-software-linux-command-line*
