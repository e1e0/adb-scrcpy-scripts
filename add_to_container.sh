if [[ $1 == 'aarch64' ]]; then
  # https://github.com/Genymobile/scrcpy/blob/master/BUILD.md#simple ,
  # https://opensource.com/article/18/8/how-install-software-linux-command-line
  apt-get install android-sdk-platform-tools
  apt-get install --reinstall binutils
  sudo apt install ffmpeg libsdl2-2.0-0 adb wget \
    gcc git pkg-config meson ninja-build libsdl2-dev \
    libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev \
    libusb-1.0-0 libusb-1.0-0-dev
  git clone https://github.com/Genymobile/scrcpy
  cd scrcpy
  eval "$(sed 's/\(sha256sum \)--check/\1-c/' ./install_release.sh)"  # \"--check\" to \"-c\".
else
  sudo -u android bash -c 'mv /sdcard/platform-tools/ ~/platform-tools/'
  # Symbolic link:
  ln -s ~/platform-tools/adb /usr/bin/adb
  apt install scrcpy # https://github.com/Genymobile/scrcpy#linux
fi