#!/usr/bin/env bash
set -ex
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

mkdir -p /opt/unigen
cd /opt/unigen
wget https://assets.unigine.com/d/Unigine_Heaven-4.0.run
chmod +x Unigine_Heaven-4.0.run
./Unigine_Heaven-4.0.run
rm Unigine_Heaven-4.0.run


cat >$HOME/Desktop/unigen.desktop <<EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=Unigen Heaven
GenericName=Graphics Utility
Comment=Unigen Heaven Benchmark
Exec=/opt/unigen/Unigine_Heaven-4.0/heaven %F
Path=/opt/unigen/Unigine_Heaven-4.0/
Terminal=false
MimeType=text/plain;
Icon=/opt/unigen/Unigine_Heaven-4.0/data/launcher/icon.png
Categories=Graphics;Utility;
StartupNotify=true
EOL

chmod +x $HOME/Desktop/unigen.desktop
chown 1000:1000 $HOME/Desktop/unigen.desktop
chown -R 1000:1000 /opt/unigen