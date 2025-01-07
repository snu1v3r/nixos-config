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

  # TODO: Move these settings to a seperate .nix file

  services.displayManager.defaultSession =
    if (systemSettings.desktop == "plasma") then "plasma" else "gnome";

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = if (systemSettings.desktop == "plasma") then true else false;
  services.desktopManager.plasma6.enable =
    if (systemSettings.desktop == "plasma") then true else false;

  # Enable the GNOME Desktop Environment
  services.xserver.displayManager.gdm.enable =
    if (systemSettings.desktop == "gnome") then true else false;
  services.xserver.desktopManager.gnome.enable =
    if (systemSettings.desktop == "gnome") then true else false;

  # TODO: Evaluate of this must be changed if gnome is uses as a desktop

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    elisa
    kate
    khelpcenter
    drkonqi
  ];

  # TODO: See if we need a "uninstall" equivalent for gnome as a desktop

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };

  #  services.picom.enable = true;
  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    xclip
    gcc
    gparted
    keepassxc
  ];

}
