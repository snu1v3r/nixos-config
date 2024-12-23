{ pkgs, systemSettings, ... }:

{
  imports = [
    ./configuration.nix
    ../common/optional/stylix
    ../common/users/root
  ];

  # This enables the machine to act as VMWare host. This is only needed for the personal profile, because This
  # is the only machine that will act as a host. The other machines will only be used for guests

  networking.hostName = "lizard";
  networking.hostId = "4e98920d";
  virtualisation.vmware.host.enable = systemSettings.vm-host;
  users.users.root = {
    shell = pkgs.zsh;
  };

}
