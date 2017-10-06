#!/bin/bash
#
# Install OpenXenManager on Ubuntu platform.
# author: Federico Silvestri <silves.federico@gmail.com>
#

TMP_LOCATION="/tmp/openxenmanager"
LOCAL_DIR=$(pwd)

# Assert root user
if [ "$EUID" -ne 0 ]; then	
	echo "You must run this script as root";
	exit -1;
fi

# Install dependecies
apt-get update
apt-get install -y git python-gtk2 glade python-gtk-vnc python-glade2 python-configobj python-setuptools

# Clone project on tmp location
git clone https://github.com/OpenXenManager/openxenmanager.git $TMP_LOCATION

# Run installation
cd $TMP_LOCATION
/usr/bin/python ./setup.py install

# Copy icons
mkdir /usr/share/openxenmanager/
cp $TMP_LOCATION/src/OXM/images/icon.png /usr/share/openxenmanager/

# Install desktop
cat <<<'
[Desktop Entry]
Version=1.0
Type=Application
Name=XenCenter
Exec=/usr/local/bin/openxenmanager
Icon=/usr/share/openxenmanager/icon.png
Categories=Development;' > ~/.local/share/applications/openxenmanager.desktop

# Cleaning
echo "Cleaning..."
rm -r $TMP_LOCATION
cd $LOCAL_DIR

echo "Open Xen Manager is successfully installed"
