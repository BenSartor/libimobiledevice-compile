#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r CURRENT_DIR="$(pwd)"
declare -r CURRENT_BUILD="libimobiledevice_$(date '+%Y%m%d_%H%M%S')"
declare -r BUILD_DIR="${CURRENT_DIR}/${CURRENT_BUILD}"
declare -r BUILD_PREFIX="${BUILD_DIR}/build/usr/local"

declare -rx PKG_CONFIG_PATH="${BUILD_PREFIX}/lib/pkgconfig/"

mkdir -p "${BUILD_DIR}/build/usr/local"

cd "${BUILD_DIR}"


git clone https://github.com/libimobiledevice/libplist.git
cd libplist
./autogen.sh
./configure --prefix="${BUILD_PREFIX}"
make
make install
cd ..


git clone https://github.com/libimobiledevice/libusbmuxd.git
cd libusbmuxd
./autogen.sh
./configure --prefix="${BUILD_PREFIX}"
make
make install
cd ..


git clone https://github.com/libimobiledevice/libimobiledevice.git
cd libimobiledevice
./autogen.sh
./configure --prefix="${BUILD_PREFIX}"
make
make install
cd ..


cd "${CURRENT_DIR}"
rm -f libimobiledevice_current
ln -s "${CURRENT_BUILD}" libimobiledevice_current

echo ""
echo "Build success: e.g. set yout path to"
echo "  export PATH=${CURRENT_DIR}/libimobiledevice_current/build/usr/local/bin:\$PATH"
echo ""
