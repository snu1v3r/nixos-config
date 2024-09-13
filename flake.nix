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
			system = "x86_64-linux";
			lib = nixpkgs.lib;
			pkgs = nixpkgs.legacyPackages.${system};
		in {
		nixosConfigurations = {
			extraSpecialArgs = { inherit inputs;};
			nixos = lib.nixosSystem {
				inherit system;
				modules = [ 
				./configuration.nix 
				home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.user = import ./home.nix;
				}
				];

			};
		};

	} ;

}
