{ config, ... }:

{
  home-manager.users.root = import ../../../../home/root/${config.networking.hostName};
}



