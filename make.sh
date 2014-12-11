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


function createLib()
{
	local -r GIT_ADDRESS=$1
	local -r NAME=$(basename --suffix=.git "${GIT_ADDRESS}")

	git clone "${GIT_ADDRESS}"
	cd "${NAME}"
	./autogen.sh
	./configure --prefix="${BUILD_PREFIX}"
	make
	make install
	cd ..
}

createLib "https://github.com/libimobiledevice/libplist.git"
createLib "https://github.com/libimobiledevice/libusbmuxd.git"
createLib "https://github.com/libimobiledevice/libimobiledevice.git"

cd "${CURRENT_DIR}"
rm -f libimobiledevice_current
ln -s "${CURRENT_BUILD}" libimobiledevice_current

echo ""
echo "Build success: e.g. set yout path to"
echo "  export PATH=${CURRENT_DIR}/libimobiledevice_current/build/usr/local/bin:\$PATH"
echo ""
