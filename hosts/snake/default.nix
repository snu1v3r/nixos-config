{ pkgs, systemSettings, ... }:

{
  imports = [
    ../common/core
    ../common/optional/stylix
    ../common/users/user
  ];

  # This enables the machine to act as VMWare host. This is only needed for the personal profile, because This
  # is the only machine that will act as a host. The other machines will only be used for guests

  networking.hostName = "snake";
  virtualisation.vmware.host.enable = systemSettings.vm-host;

}
