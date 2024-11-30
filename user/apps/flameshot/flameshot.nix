{ pkgs, ... }:

{
  services.flameshot.enable = true;
  services.flameshot.settings = {
    General = {
      startupLaunch = true;
      showStartupLaunchMessage = false;
    };
  };
}

