function continue_script_new_shell () {
  env echo '$2' > /sdcard/$1.sh
  next="mv /sdcard/$1.sh ~/ && { . ~/$1.sh && rm ~/$1.sh; }"
}

if [[ $1 == 'aarch64' ]]; then
  # https://github.com/Genymobile/scrcpy/blob/master/BUILD.md#simple,
  # Replace BusyBox package with apt package
  mount -o rw,remount /system 2>/dev/null || mount -o rw,remount / 2>/dev/null
  rm /system/xbin/ar

  # https://opensource.com/article/18/8/how-install-software-linux-command-line
  continue_script_new_shell '_' "\
apt-get install android-sdk-platform-tools\n\n\
apt-get install --reinstall binutils\n\
\n\
sudo apt install ffmpeg libsdl2-2.0-0 adb wget \\n\
  gcc git pkg-config meson ninja-build libsdl2-dev \\n\
  libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev \\n\
  libusb-1.0-0 libusb-1.0-0-dev\n\
git clone https://github.com/Genymobile/scrcpy\n\
cd scrcpy\n\
eval \"\$(sed 's/\(sha256sum \)--check/\1-c/' ./install_release.sh)\"  # \"--check\" to \"-c\"."
else
  continue_script_new_shell '_' "\
sudo -u android bash -c 'mv /sdcard/platform-tools/ ~/platform-tools/'\n\
# Symbolic link:\n\
ln -s ~/platform-tools/adb /usr/bin/adb\n\
\n\
apt install scrcpy # https://github.com/Genymobile/scrcpy#linux"
fi

/data/data/ru.meefik.linuxdeploy/files/bin/linuxdeploy -p linux shell ${next}