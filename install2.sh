echo -n "Installing Dolphin {anty}... "
wget "https://github.com/dolphinrucom/anty-releases/releases/download/v2022.7.10/dolphin-anty-linux-x86_64-latest.AppImage" -O /opt/dolphin &> /dev/null
chmod +x /opt/dolphin
mkdir -p /root/Desktop/
echo "$desktop" > /root/Desktop/dolphin.desktop
echo "${GREEN}Done${NC}"

read -r -p "Reboot? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    reboot
fi
