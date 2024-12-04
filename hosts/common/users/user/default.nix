{ config, pkgs,  ... }:

{
  config = {
      users.users.user = {
      home = "/home/user";
      isNormalUser = true;

      extraGroups = [ "wheel" ];
    };
    
    home-manager.users.user = import ../../../../home/user/${config.networking.hostName};

  };
}



