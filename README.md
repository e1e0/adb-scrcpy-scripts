# adb-scrcpy-scripts
Bash scripts for Android screen control in a Linux Deploy "chroot".

## adb - copy file to Termux [shortcuts](https://github.com/termux/termux-widget#readme), set permissions:

File "TERMUX_scrcpy_in_Linux_script.sh":

 1. `... platform-tools/adb push TERMUX_scrcpy_in_Linux_script.sh /sdcard/TERMUX_scrcpy_in_Linux_script.sh`
 2. https://wiki.termux.com/wiki/Internal_and_external_storage
 3. Termux: `mv ~/storage/shared/TERMUX_scrcpy_in_Linux_script.sh ~/.shortcuts/TERMUX_scrcpy_in_Linux_script.sh`
 4. Termux: `chmod +rwx ~/.shortcuts/TERMUX_scrcpy_in_Linux_script.sh`

## Adding `adb` and `scrcpy` to a Linux Deploy container
(profile: "linux", GUI + VNC subsystem + Mounts enabled in "Properties" - mounts: "/system/" > "/system/",  
`mkdir /data/local/mnt/etc/` if it doesn't exist, update Settings > PATH variable "/system/xbin", https://github.com/meefik/linuxdeploy#faq)

```bash
           $ ... platform-tools/adb shell
             $ su
           ....# /data/data/ru.meefik.linuxdeploy/files/bin/linuxdeploy -p linux shell
root@localhost...# uname -m    # The machine hardware name
```

### "x86_64" machine hardware:

https://developer.android.com/studio/releases/platform-tools#downloads

Properties -> mounts -> + new "/sdcard/" > "/sdcard/".
`cp -R` the folder in "/sdcard/".

### "aarch64" machine hardware:

- [`apt-get`](https://opensource.com/article/18/8/how-install-software-linux-command-line)` install android-sdk-platform-tools`.
- or do https://github.com/thejunkjon/android-tools (Properties -> mounts -> + new "/sdcard/" > "/sdcard/",  
 `cp -R` it from "/sdcard/").

### `scrcpy`:
