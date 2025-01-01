#!/bin/sh
echo "-----"

if command -v git &> /dev/null; then
  echo "Git is installed, continuing with installation."
  echo "-----"
else
  echo "Git is not installed. Please install Git and try again."
  echo "Example: nix-shell -p git"
  exit
fi

echo "-----"

echo "Ensure In Home Directory"
cd || exit

echo "Cloning & Entering Repository"
git clone https://github.com/snu1v3r/nixos-config.git
cd nixos-config || exit
git config --global user.name "snu1v3r"
git config --global user.email "snu1v3r@github.com"

echo "-----"

echo "Ensure In Home Directory"
cd || exit

if [ $# -gt 0 ]
then
	SCRIPT_DIR=$1
else
	SCRIPT_DIR=~/nixos-config
fi

cd $SCRIPT_DIR

if [ -f './flake.nix' ]; then
  echo "-----"
  echo "flake.nix exists install script will exit"
  echo "manually verify the content of flake.nix"
  echo "and rebuild the system with:"
  echo ""
  echo "  ./rebuild.sh [system_name]"
  echo ""
  echo "or remove the existing flake.nix and restart"
  echo "the install script"
  exit
else
  cp ./flake_template.nix ./flake.nix
fi


read -rp "Which system to configure (walrus | snake | raptor | hawk | dragon | lizard ): [walrus] " system
if [ -z "$system" ]; then
  system="walrus"
fi


read -rp "Load Nvidia drivers (no | yes ):  [no] " graphics
if [ -z "$graphics" ]; then
  graphics="no"
fi

if [ $graphics = "yes" ]; then
  echo "-----"
  echo "Configuration modified for Nvidia graphics drivers"
  sed -i "/^\s*nvidiaDrivers[[:space:]]*=[[:space:]]*/s/\(true\|false\)/true/" ./flake.nix
fi

echo "-----"
detect_systemd=`cat /etc/nixos/configuration.nix|sed -n "s/^.*systemd-boot.*\(true\|false\);$/\1/p"`
if [ "$detect_systemd" == "true" ]; then
  echo "Systemd was detected as bootloader"
  sed -i "/^\s*bootLoader\s*=\s*/s/\"\(.*\)\"/\"systemd\"/" ./flake.nix
else
  detect_grub=`cat /etc/nixos/configuration.nix|sed -n "s/^.*boot.loader.grub.enable.*\(true\|false\);$/\1/p"`
  if [ "$detect_grub" == "true" ]; then
    echo "Grub was detected as bootloader"
    detect_device=`cat /etc/nixos/configuration.nix|sed -n "s/^.*boot.loader.grub.device.*\"\(.*\)\";$/\1/p"`
    echo "Grub boot device detected: $detect_device"
    sed -i "/^\s*bootLoader\s*=\s*/s/\"\(.*\)\"/\"grub\"/" ./flake.nix

    # : is used as an argument seperator in the sed command because of the / character in the device names
    sed -i "/^\s*bootDevice\s*=\s*/s:\"\(.*\)\":\"$detect_device\":" ./flake.nix
  fi
fi
echo "-----"
echo "Generating Harware Configuration"
sudo nixos-generate-config --show-hardware-config > $SCRIPT_DIR/system/hardware-configuration.nix

echo "-----"
echo "Setting Required Nix Settings Then Going To Install"

./rebuild.sh $system

