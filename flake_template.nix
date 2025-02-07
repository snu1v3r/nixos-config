{
  description = "Nixos config flake";

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      stylix,
      ...
    }@inputs:
    let
      # --- GLOBAL SYSTEM SETTINGS --- #
      systemSettings = {
        system = "x86_64-linux"; # system arch
        timezone = "Europe/Amsterdam";
        locale = "en_US.UTF-8";
        nvidiaDrivers = false;
        bootLoader = "systemd";
        bootDevice = ""; # Only applicable when bootloader is grub
        vmGuestType = "none"; # options are: vmware, spice, qemu, none
        vmHost = "none";
        swapsize = 8; # Size of the swapfile in GB
        hostname = "walrus";
        #        useSops = false;
      };

      # --- GLOBAL USER SETTINGS --- #
      userSettings = {
        username = "user";
        name = "User";
        dotfilesDir = "~/nixos-config";
        emulator = "alacritty"; # options are: kitty, alacritty
        browser = "brave";
        prompt = "p10k"; # options are: starship, p10k, oh-my-posh
      };

    in
    #pkgs = nixpkgs.legacyPackages.${systemSettings.system};
    {
      nixosConfigurations = {
        # A machine used for generic work environment
        ${systemSettings.hostname} = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit systemSettings;
            inherit userSettings;
          };
          modules = [
            ./hosts/${systemSettings.hostname}
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
              home-manager.extraSpecialArgs = {
                inherit userSettings;
              };
            }
          ];
        };
      };
    };

  inputs = {
    ### Base NixOS packages (is used per default)
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };

    ### Unstable NixOS packages in certain use cases (is only used when specifically indicated)
    nixpkgs-unstable = {
      url = "nixpkgs/nixos-unstable";
    };

    ### Stylix for easy configuration of environment theme
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    ### Fixes vscode extensions hashes
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };

    ### SOPS is used for secrets management
    #    sops-nix = {
    #      url = "github:Mic92/sops-nix";
    #      inputs.nixpkgs.follows = "nixpkgs";
    #    };

    ### This is the repo where my secrets are stored
    #    nix-secrets = {
    #      url = "git+ssh://git@github.com/snu1v3r/nix-secrets?shallow=1&ref=main";
    #      inputs.nixpkgs.follows = "nixpkgs";
    #      flake = false;
    #    };
  };

}
