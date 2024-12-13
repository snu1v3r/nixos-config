{ config, pkgs, inputs,  ... }:
let
#  secretspath = builtins.toString inputs.nix-secrets;

in 
{
  config = {
    users.users.user = {
      home = "/home/user";
      isNormalUser = true;
#      hashedPasswordFile = config.sops.secrets.user_passwd.path;
      shell = pkgs.zsh;
      extraGroups = [ 
        "wheel"
        "networkmanager"
      ];
    };
#    sops = {
#      defaultSopsFile = "${secretspath}/secrets.yaml";
#      age = {
#        sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
#        keyFile = "/var/lib/sops-nix/key.txt";
#        generateKey = true;
#      };
#      secrets = {
#        user_passwd = {
#          neededForUsers = true;
#        };
#      };
#    };
  
    #    home-manager.users.user = import ../../../../home/user/${config.networking.hostName};

  };
}



