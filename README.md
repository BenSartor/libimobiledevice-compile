libimobiledevice-compile
========================

This script checks out and compiles the latest tags of libimobiledevice and its dependencies. It's purpose is to make the install of libimobiledevice simple on MacOS X. No administration priveleges are reguired as it creates a local folder and places everything in there. Even though this script runs quiet well on linux it is not reasonable because we do not compile usbmuxd.

## Uninstall
Simply remove the folder(s) the script creates and the script.

## MacPorts
I have installed a couple of MacPorts packages like bash, gnutls, autoconf and automake. This script is **not tested without**.