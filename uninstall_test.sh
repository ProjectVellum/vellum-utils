#!/bin/bash
# This file UNINSTALLS targeted packages using pip3, so run it on your own risk!
# It ment to be used on container as part of the python package uninstall test.

#The name of the package as found by pip3 show
PKG_NAME="$1"
#The name of the package directory created under ...python3.7/site-packages/
PKG_DIR_NAME="$2"

DIR_PATH="~/.local/lib/python3.7/site-packages/$PKG_DIR_NAME"
echo $DIR_PATH

echoerr() { echo "$@" 1>&2; }

pip3 show $PKG_NAME

if [ $? -gt 0 ]; then
    echoerr "- ! - pip3 show $PKG_NAME found nothing?"
    exit 1
fi

echo "- $PKG_NAME found... uninstalling."
pip3 uninstall -y $PKG_NAME

pip3 show $PKG_NAME

if [ $? -eq 0 ]; then
    echoerr "- ! - pip3 show $PKG_NAME was not uninstalled?"
    exit 1
fi

if [ -e $DIR_PATH ]; then
    echoerr "- ! - uninstalled with pip3 but package dir is still there at $DIR_PATH"
    exit -1
fi

echo "- SUCCESS"