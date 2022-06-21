# adb-scrcpy-scripts
Bash scripts for Android screen control in a Linux Deploy "chroot".

## adb - copy file to Termux [shortcuts](https://github.com/termux/termux-widget#readme)

```
 ... platform-tools/adb push TERMUX_scrcpy_in_Linux_script.sh /sdcard/TERMUX_scrcpy_in_Linux_script.sh
 ... platform-tools/adb shell
 $ su --command "cp /sdcard/TERMUX_scrcpy_in_Linux_script.sh /data/data/com.termux/files/home/.shortcuts/TERMUX_scrcpy_in_Linux_script.sh"
 [Ctrl+D]
 ```
