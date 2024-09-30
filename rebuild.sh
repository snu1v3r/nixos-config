#!/bin/sh

if [ $# -gt 0 ]
then
	SCRIPT_DIR=$1
else
	SCRIPT_DIR=~/nixos-config
fi
hms=`date +%Y%m%d-%H%M`
branch=`(git branch 2>/dev/null | sed -n '/^\* / { s|^\* ||; p; }')`
revision=`(git rev-parse HEAD)`
nixversion=`nixos-version | sed 's/\(.*\) .*/\1/'`
sudo NIXOS_LABEL="$nixversion-$hms.$branch-${revision:0:7}" nixos-rebuild switch --impure --flake $SCRIPT_DIR#system
