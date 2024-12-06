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
        timezone = "Europe/Amsterdam";
        locale = "en_US.UTF-8";
        nvidiaDrivers = false;
        bootloader = "grub";
        vmGuestType = "vmware"; # options are: vmware, spice, qemu, none
        vmHost = false;
        swapsize = 8; # Size of the swapfile in GB

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
            ./hosts/walrus # this is a normal work machine with a graphical desktop
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
        raptor = lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            ./hosts/raptor # this is a machine with a graphical desktop and a specific set of tools for reverse engineering
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
        hawk = lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            ./hosts/hawk # this is a machine with a graphical desktop and a specific set of tools for hacking
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ inputs.stylix.homeManagerModules.stylix plasma-manager.homeManagerModules.plasma-manager ];
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
        snake = lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            ./hosts/snake # this is bare-bone machine without a graphical user interface specifically intended for servers
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
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
        dragon = lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            ./hosts/dragon # this is normal machine with a graphical user interface specifically intended for code development
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
        lizard = lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            ./hosts/lizard # this is base machine intended to run in a lxc container
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
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
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

}
