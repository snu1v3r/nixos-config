{
  description = "Home Manager configuration of user";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs = {
    	url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### Plasma configuration
    plasma-manager = {
      url = "github:nix-community/plasma-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    { nixpkgs, home-manager, plasma-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
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
    {
      homeConfigurations = {
        "user@walrus" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [ ./user/walrus plasma-manager.homeManagerModules.plasma-manager];

	extraSpecialArgs = {
	inherit userSettings;
	};
          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix

        };

      };
    };
}
