#!/usr/bin/env bash

# Set $XONOTIC_DEDICATED to override.
XONOTIC=""

if [ -n "$XONOTIC_DEDICATED" ]; then
    XONOTIC="$XONOTIC_DEDICATED"
elif which xonotic-linux64-dedicated &>/dev/null; then
    XONOTIC=xonotic-linux64-dedicated
elif which xonotic-dedicated &>/dev/null; then
    XONOTIC=xonotic-dedicated
else
    XONOTIC=./Xonotic/xonotic-linux64-dedicated
fi

mkdir -p userdir/data || exit 1
rm -f userdir/data/*.cfg
cp server/*.cfg userdir/data/ || exit 1

if $(which daemon &>/dev/null); then
    exec daemon -r -o $(pwd)/xonotic.log "$XONOTIC" -userdir $(pwd)/userdir
else
    echo "!!! No \`daemon\` executable. (Probably not FreeBSD?)"
    exec "$XONOTIC" -userdir $(pwd)/userdir
fi
