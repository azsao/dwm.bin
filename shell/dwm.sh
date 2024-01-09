#!/bin/bash

# install dependencies
echo "Installing necessary dependencies"
sudo pacman -S --noconfirm base-devel git libx11 libxft libxinerama xorg-server xorg-xinit terminus-font freetype2 fontconfig

# install suckless shit
echo "Installing suckless resources"
mkdir .suckless
cd .suckless
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/st
git clone https://git.suckless.org/dmenu

echo "Making suckless resources"
cd .suckless/dwm
make
sudo make clean install

cd .suckless/st
make
sudo make clean install

cd .suckless/dmenu
make
sudo make clean install

# make .desktop for display manager
echo "Creating Login Manager Entry for DWM"
cd /usr/share/xsessions
sudo touch dwm.desktop
sudo chown $USER dwm.desktop
sudo cat > dwm.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Dwm
Comment=the dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
EOF

# adding clean install command to terminal for easy compiling
echo 'dwm_cleaninstall() { cd $HOME/.suckless/dwm && make && sudo make clean install; }' >> ~/.bashrc
source ~/.bashrc

