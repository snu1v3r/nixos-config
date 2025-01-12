{
  pkgs,
  systemSettings,
  lib,
  pkgs-unstable,
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
  networking.hostName = "hawk";

  # Enable CUPS to print documents.
  services.printing.enable = false;

  environment.systemPackages =
    (with pkgs; [
      # These packages are added systemwide, because they do not require user specific configuration and need
      # to be available for both the user and the root

      # Generic Tools
      python3Full
      nmap
      wordlists
      python312Packages.impacket
      bloodhound
      neo4j # start with the `sudo NEO4J_HOME=/home/user/.neo4j neo4j start` command to mitigate issue with non-writable application folder
      netcat-openbsd
      openvpn
      remmina

      # website directory and vhost fuzzing
      gobuster
      feroxbuster
      netexec
      wfuzz
      thc-hydra

      # password cracking
      hashcat
      john
      havoc-client
      havoc-server
    ])
    ++ (with pkgs-unstable; [

      metasploit # metasploit in the stable branch appears to be broken
    ]);
  nixpkgs.config.packageOverrides = pkgs: {
    havoc-client = pkgs.libsForQt5.callPackage ../../packages/havoc/client.nix { };
    havoc-server = pkgs.callPackage ../../packages/havoc/server.nix { };
  };

}
