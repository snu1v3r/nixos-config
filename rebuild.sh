#!/bin/sh

if [ $# -gt 0 ]
then
	system=$1
else
  system=walrus
fi

SCRIPT_DIR=~/nixos-config
hms=`date +%Y.%m.%d-%H%M`
branch=`(git branch 2>/dev/null | sed -n '/^\* / { s|^\* ||; p; }')`
revision=`(git rev-parse HEAD)`
nixversion=`nixos-version | sed 's/\(.*\) .*/\1_/'`
rm ~/.gtkrc-2.0
sudo NIXOS_LABEL="$nixversion$hms.$branch-${revision:0:7}" nixos-rebuild switch --impure --flake $SCRIPT_DIR#$system
