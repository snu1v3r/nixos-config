{ config, pkgs, ... }:

{
  users.users.root = {
    shell = pkgs.zsh;
  };

  #  home-manager.users.root = import ../../../../home/root/${config.networking.hostName};
}



