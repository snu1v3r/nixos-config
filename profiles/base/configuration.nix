# Edit this configuration file to define what should be installed an
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, systemSettings, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../system/hardware-configuration.nix
      ../../system/nvidia-drivers.nix
      ../../system/vm-guest-services.nix
    ];


  # Bootloader.
  boot.loader.grub.enable = if (systemSettings.bootloader == "grub") then true else false;
  boot.loader.grub.device = if (systemSettings.bootloader == "grub") then "/dev/sda" else "";
  boot.loader.grub.useOSProber = if (systemSettings.bootloader == "grub") then true else false;
  boot.loader.systemd-boot.enable = if (systemSettings.bootloader == "systemd") then true else false;
  boot.loader.efi.canTouchEfiVariables = if (systemSettings.bootloader == "systemd") then true else false;

  swapDevices = [{
    device = "/swapfile";
    size = 8 * 1024; # 8 GB swapfile
  }];

  networking.hostName = systemSettings.hostname;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.xserver.desktopManager.xterm.enable = false;

  

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.defaultSession = "plasma";
  services.displayManager.sddm.enable = true;

  services.desktopManager.plasma6.enable = true;
  
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    elisa
    kate
    khelpcenter
  ];

  
  vm.guest-services.enable = systemSettings.vm-guest;
  drivers.nvidia.enable = systemSettings.nvidia-drivers;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };

#  services.picom.enable = true;
  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    description = "user";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs = { 
  	firefox.enable = false;
    zsh.enable = true;
	};


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  

  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
  	experimental-features = nix-command flakes
  '';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	neovim
	xclip
  gcc
  gparted
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;



  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enabling Nix Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "unstable"; # Did you read the comment?

  fonts.packages = with pkgs; [
  (nerdfonts.override { fonts = [ "Meslo" ];})
  ];

}
