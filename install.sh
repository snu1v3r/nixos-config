#!/bin/sh

if [ $# -gt 0 ]
then
	SCRIPT_DIR=$1
else
	SCRIPT_DIR=~/nixos-config
fi

sudo nixos-generate-config --show-hardware-config > $SCRIPT_DIR/system/hardware-configuration.nix

sudo nixos-rebuild switch --flake $SCRIPT_DIR#system;

