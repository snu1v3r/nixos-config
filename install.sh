#!/bin/sh
echo "-----"

read -rp "Special Graphics Driver (none | nvidia ):  [none] " graphics
if [ -z "$graphics" ]; then
  graphics="none"
fi

if [ $graphics = "nvidia" ]; then
  echo "-----"
  echo "Configuration modified for Nvidia graphics drivers"
  sed -i "/^\s*nvidia-drivers[[:space:]]*=[[:space:]]*/s/\(true\|false\)/true/" ./flake.nix
else
  echo "-----"
  echo "Configuration modified for default graphics drivers" 
  sed -i "/^\s*nvidia-drivers[[:space:]]*=[[:space:]]*/s/\(true\|false\)/false/" ./flake.nix
fi

read -rp "Which profile should be used ( personal | hacking ): [personal] " profile
if [ -z "$profile" ]; then
  profile="personal"
fi

if [ $profile = "hacking" ]; then
  echo "-----"
  echo "Configuration modified for 'hacking' profile"
  sed -i "/^\s*profile\s*=\s*/s/\"\(.*\)\"/\"$profile\"/" ./flake.nix
else
  echo "-----"
  echo "Configuration modified for 'personal' profile"
  sed -i "/^\s*profile\s*=\s*/s/\"\(.*\)\"/\"$profile\"/" ./flake.nix
fi

if [ $# -gt 0 ]
then
	SCRIPT_DIR=$1
else
	SCRIPT_DIR=~/nixos-config
fi

echo "-----"
echo "Generating Harware Configuration"
sudo nixos-generate-config --show-hardware-config > $SCRIPT_DIR/system/hardware-configuration.nix

echo "-----"
hms=`date +%Y.%m.%d-%H%M`
branch=`(git branch 2>/dev/null | sed -n '/^\* / { s|^\* ||; p; }')`
revision=`(git rev-parse HEAD)`
nixversion=`nixos-version | sed 's/\(.*\) .*/\1_/'`

echo "Setting Required Nix Settings Then Going To Install"
NIX_CONFIG="experimental-features = nix-command flakes"
NIXOS_LABEL="$nixversion$hms.$branch-${revision:0:7}" 
sudo nixos-rebuild switch --impure --flake $SCRIPT_DIR#system

