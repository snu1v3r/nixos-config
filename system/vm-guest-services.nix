{ systemSettings, ... }:
{

  config = {
    services.qemuGuest.enable = if systemSettings.vmGuestType == "qemu" then true else false;
    services.spice-vdagentd.enable = if systemSettings.vmGuestType == "spice" then true else false;
    services.spice-webdavd.enable = if systemSettings.vmGuestType == "spice" then true else false;
    virtualisation.vmware.guest.enable = if systemSettings.vmGuestType == "vmware" then true else false;
  };
}
