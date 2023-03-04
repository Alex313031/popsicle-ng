set -e

export APPIMAGE_EXTRACT_AND_RUN=1
apt-get update
apt-get install -y cargo help2man libclang1 libclang-dev libdbus-1-dev libgtk-3-dev libudev-dev patchelf
wget https://github.com/TheAssassin/appimagecraft/releases/download/continuous/appimagecraft-x86_64.AppImage
chmod +x appimagecraft-x86_64.AppImage
./appimagecraft-x86_64.AppImage
