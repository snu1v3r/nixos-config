{ pkgs, systemSettings, ... }:

{
  imports = [
    ../common/core
    ../common/optional/base_gui
    ../common/optional/stylix
    ../common/users/user
    ../common/users/root
    ]
    ++ lib.optionals (systemSettings.vmHost == "qemu") [ ../common/optional/qemu_host ]
    ++ lib.optionals (systemSettings.vmHost == "vmware") [ ../common/optional/vmware_host ];

  # This enables the machine to act as VMWare host. This is only needed for the personal profile, because This
  # is the only machine that will act as a host. The other machines will only be used for guests
  networking.hostName = "walrus";


}
