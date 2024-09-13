{ 

	description = "Basic Flake configuration!";
	
	inputs = {
	

		nixpkgs.url= "nixpkgs/nixos-24.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

	} ;

	outputs = inputs@{ nixpkgs, home-manager, ...}:
		let
			# --- GLOBAL SYSTEM SETTINGS --- #
			systemSettings = {
				system = "x86_64-linux"; # system arch
				hostname = "nixos"; # hostname
				profile = "personal";
				timezone = "Europe/Amsterdam";
				locale = "en_US.UTF-8";
			};

			# --- GLOBAL USER SETTINGS --- #
			userSettings = {
				username = "user";
				name = "User";
				dotfilesDir = "~/nixos-config";
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
