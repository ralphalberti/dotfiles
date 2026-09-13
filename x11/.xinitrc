#!/bin/sh

# Identify this session as Plasma.
export DESKTOP_SESSION=plasma

# Load system X11 initialization snippets.
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Start KDE Plasma.
exec startplasma-x11
