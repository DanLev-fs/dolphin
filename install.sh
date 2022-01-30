#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
xfce4settings="$(cat <<-EOF
#!/bin/sh
if [ -r /etc/default/locale ]; then
  . /etc/default/locale
  export LANG LANGUAGE
fi
startxfce4
EOF
)"

desktop="$(cat <<-EOF
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

function checkError {
	if [ $? -eq 1 ] 
	then 
		echo "${RED}Error${NC}"
		exit 1 
	fi
}

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo -n "Apt update... "
apt-get update 1> /dev/null
checkError
echo "${GREEN}Done${NC}"

echo -n "Installing XFCE4..."
apt-get install xfce4 xfce4-terminal tango-icon-theme -y &> /dev/null
checkError
echo "${GREEN}Done${NC}"

echo -n "Installing XRDP... "
apt-get install xrdp -y &> /dev/null
checkError
echo "${GREEN}Done${NC}"

echo -n "Configuring... "
echo xfce4-session >~/.xsession &> /dev/null
mkdir -p /etc/xrdp/ &> /dev/null
echo "$xfce4settings" > /etc/xrdp/startwm.sh
ufw allow 3389 &> /dev/null
echo "${GREEN}Done${NC}"

systemctl enable xrdp &> /dev/null

echo -n "Installing Dolphin {anty}... "
wget "https://github.com/dolphinrucom/anty-releases/releases/latest/download/dolphin-anty-linux-x86_64-latest.AppImage" -O /opt/dolphin &> /dev/null
chmod +x /opt/dolphin
mkdir -p /root/Desktop/
echo "$desktop" > /root/Desktop/dolphin.desktop
chmod +x /root/Desktop/dolphin.desktop
echo "${GREEN}Done${NC}"
