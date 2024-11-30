{

  description = "Basic Flake configuration!";

  outputs =
    {
      nixpkgs,
      home-manager,
      plasma-manager,
      ...
    }@inputs:
    let
      # --- GLOBAL SYSTEM SETTINGS --- #
      systemSettings = {
        system = "x86_64-linux"; # system arch
        hostname = "nixos"; # hostname
        timezone = "Europe/Amsterdam";
        locale = "en_US.UTF-8";
        nvidia-drivers = false;
        bootloader = "grub";
        vm-guest-type = "vmware"; # options are: vmware, spice, qemu, none
        vm-host = false;

      };

      # --- GLOBAL USER SETTINGS --- #
      userSettings = {
        username = "user";
        name = "User";
        dotfilesDir = "~/nixos-config";
        emulator = "alacritty"; # options are: kitty, alacritty
        browser = "brave";
        prompt = "p10k"; # options are: starship, p10k, oh-my-posh
## walrus is a normal work machine
## shark is a gui-less server machine
## killerwhale is a hacking machine
## barracuda is a reversing machine
      };

      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
    in
    {
      nixosConfigurations = {
        extraSpecialArgs = {
          inherit inputs;
        };
        walrus = lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            ./hosts/work
            inputs.stylix.nixosModules.stylix
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
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
        };
      };
    };

  inputs = {

    ###### Packages URL-s ######

    ### Base NixOS packages
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
    };

    ### Home manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### Plasma configuration
    plasma-manager = {
      url = "github:nix-community/plasma-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    ### Fixes vscode extensions hashes
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };

    ### Stylix for easy configuration of environment
    stylix = {
      url = "github:danth/stylix";
    };
  };

}
