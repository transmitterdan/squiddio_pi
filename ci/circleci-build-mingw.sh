#!/bin/sh  -xe

#
# Build the mingw artifacts inside the Fedora container
#

set -xe

su -c "dnf install -q -y sudo dnf-plugins-core"
sudo dnf -q builddep  -y mingw/fedora/opencpn-deps.spec
rm -rf build; mkdir build; cd build
cmake -DCMAKE_TOOLCHAIN_FILE=../mingw/fedora/toolchain.cmake ..
make -j2
make package

# Install cloudsmith-cli, used in upload
sudo dnf install python3-pip python3-setuptools
sudo python3 -m pip install -q cloudsmith-cli
