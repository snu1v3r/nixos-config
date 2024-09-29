#!/bin/sh

if [ $# -gt 0 ]
then
	SCRIPT_DIR=$1
else
	SCRIPT_DIR=~/nixos-config
fi
today=`date +%Y%m%d-%H%M`
branch=`(git branch 2>/dev/null | sed -n '/^\* / { s|^\* ||; p; }')`
revision=`(git rev-parse HEAD)`
export VERSION="$today.$branch-${revision:0:7}"
sudo NIXOS_LABEL="$VERSION" nixos-rebuild switch --impure --flake $SCRIPT_DIR#system
