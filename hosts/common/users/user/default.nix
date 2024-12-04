{ config, pkgs,  ... }:

{
  config = {
      users.users.user = {
      home = "/home/user";
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ 
        "wheel"
        "networkmanager"
      ];
    };
    
    home-manager.users.user = import ../../../../home/user/${config.networking.hostName};

  };
}



