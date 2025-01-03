{ pkgs, ... }:

{
  config.services.syncthing = {
    enable = true;
    guiAddress = "127.0.0.1:8384";
    tray.enable = true;
    overrideDevices = false; # Enables that devices add through the gui perist. Adding devices through the .nix file is not done due to the sensitive ID
    overrideFolders = false; # Enables that folder added through the gui persist
    settings = {
      gui = {
        theme = "black";
      };
    };
  };
}
