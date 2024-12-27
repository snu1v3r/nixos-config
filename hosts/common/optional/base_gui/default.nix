{
  config,
  pkgs,
  inputs,
  systemSettings,
  userSettings,
  lib,
  ...
}:

{
  imports = [
    # This is a placeholder for the default files to import
  ] ++ lib.optionals (systemSettings.nvidiaDrivers == true) [ ../../../../system/nvidia-drivers.nix ];

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.xserver.desktopManager.xterm.enable = false;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.defaultSession = "plasma";
  services.displayManager.sddm.enable = true;

  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    elisa
    kate
    khelpcenter
  ];


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };

  #  services.picom.enable = true;
  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = false;
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    xclip
    gcc
    gparted
    keepassxc
    thunderbird
  ];

}
