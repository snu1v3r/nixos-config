{
  pkgs,
  systemSettings,
  lib,
  ...
}:

{
  imports =
    [
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

  # Enable CUPS to print documents.
  services.printing.enable = true;
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    thunderbird
    libreoffice-qt6
  ];

}
