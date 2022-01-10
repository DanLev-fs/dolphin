#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

desktopIconvar="$(cat <<-EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=dolphin
Comment=
Exec=/opt/dolphin --no-sandbox
Icon=
Path=
Terminal=false
StartupNotify=false
EOF
)"

echo -n "Installing Dolphin {anty}... "
wget "https://github.com/dolphinrucom/anty-releases/releases/download/v2022.7.10/dolphin-anty-linux-x86_64-latest.AppImage" -O /opt/dolphin &> /dev/null
chmod +x /opt/dolphin
mkdir -p /root/Desktop/
echo "$desktopIconvar" > /root/Desktop/dolphin.desktop
echo "${GREEN}Done${NC}"

read -r -p "Reboot? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]];
then
    reboot;
fi
