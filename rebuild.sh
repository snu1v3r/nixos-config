#!/bin/sh

if [ $# -gt 0 ]
then
	system=$1
else
  system=$(hostname)
fi
SCRIPT_DIR=~/nixos-config
hms=`date +%Y.%m.%d-%H%M`
branch=`(git branch 2>/dev/null | sed -n '/^\* / { s|^\* ||; p; }')`
revision=`(git rev-parse HEAD)`
nixversion=`nixos-version | sed 's/\(.*\) .*/\1_/'`

if [ -f ~/.gtkrc-2.0 ]; then
  rm ~/.gtkrc-2.0
fi
sudo NIXOS_LABEL="$nixversion$hms.$branch-${revision:0:7}" nixos-rebuild switch --impure --flake path:$SCRIPT_DIR#$system
