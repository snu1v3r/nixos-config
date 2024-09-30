#!/bin/sh

if [ $# -gt 0 ]
then
	SCRIPT_DIR=$1
else
	SCRIPT_DIR=~/nixos-config
fi

sudo nixos-generate-config --show-hardware-config > $SCRIPT_DIR/system/hardware-configuration.nix

today=`date +%Y%m%d-%H%M`
branch=`(git branch 2>/dev/null | sed -n '/^\* / { s|^\* ||; p; }')`
revision=`(git rev-parse HEAD)`
sudo NIXOS_LABEL="$today.$branch-${revision:0:7}" nixos-rebuild switch --impure --flake $SCRIPT_DIR#system

