#!/bin/sh

if [ $# -gt 0 ]
then
	SCRIPT_DIR=$1
else
	SCRIPT_DIR=~/nixos-config
fi

sudo nixos-rebuild switch --flake $SCRIPT_DIR#system;
