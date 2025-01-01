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

  # Enable CUPS to print documents.
  services.printing.enable = true;
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    thunderbird
    libreoffice-qt6
  ];

}
