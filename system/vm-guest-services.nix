{ lib, config, ... }:
with lib;
let cfg = config.vm.guest-services;
in {
  options.vm.guest-services = {
    type = mkOption {
      type = types.strMatching "(vmware|qemu|spice|none)";
      default = "none";
      description = "Which type of vmware guest additions should be used";
    };
  };
  config = {
    services.qemuGuest.enable = if cfg.type == "qemu" then true else false;
    services.spice-vdagentd.enable =
      if cfg.type == "spice" then true else false;
    services.spice-webdavd.enable = if cfg.type == "spice" then true else false;
    virtualisation.vmware.guest.enable =
      if cfg.type == "vmware" then true else false;
  };
}
