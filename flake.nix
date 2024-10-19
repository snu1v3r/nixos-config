{ 

	description = "Basic Flake configuration!";
	
	inputs = {
	

		nixpkgs.url= "nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};
    
    plasma-manager = {
      url = "github:nix-community/plasma-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
   
   nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
	};

	outputs = inputs@{ nixpkgs, home-manager, plasma-manager, ...}:
		let
			# --- GLOBAL SYSTEM SETTINGS --- #
			systemSettings = {
				system = "x86_64-linux"; # system arch
				hostname = "nixos"; # hostname
				profile = "personal";
				timezone = "Europe/Amsterdam";
				locale = "en_US.UTF-8";
        nvidia-drivers = false;
        bootloader = "grub";
        vm-guest = true;

			};

			# --- GLOBAL USER SETTINGS --- #
			userSettings = {
				username = "user";
				name = "User";
				dotfilesDir = "~/nixos-config";
        emulator = "kitty";
        browser = "brave-browser";
			};

			lib = nixpkgs.lib;
			pkgs = nixpkgs.legacyPackages.${systemSettings.system};
		in {
		nixosConfigurations = {
			extraSpecialArgs = { inherit inputs;};
			system = lib.nixosSystem {
				system = systemSettings.system;
				modules = [ 
				( ./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
				home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
          home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
					home-manager.users.user = import ( ./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix");
					home-manager.extraSpecialArgs = { inherit userSettings;};
				}
				];
				specialArgs = {
					inherit systemSettings;
					inherit inputs;
				};


			};
		};

	} ;

}
