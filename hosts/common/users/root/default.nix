{ config, ... }:

{
  home-manager.users.user = import ../../../../home/user/${config.networking.hostName};
}



