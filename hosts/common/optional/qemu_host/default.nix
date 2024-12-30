{ pkgs,  ... }:

{
	programs.virt-manager.enable = true;
	# TODO Ensure that the username is taken from the settings
	users.groups.libvirtd.members = ["user"];
	virtualisation.libvirtd.enable = true;
	virtualisation.spiceUSBRedirection.enable = true;

	environment = {
		systemPackages = [ pkgs.qemu ];

	};

}
