{ pkgs, ...}:

{

imports = [
  ../apps/tmux/tmux.nix
  ../apps/nvim/nvim.nix
];
	programs = {
		bat = {
			enable = true;
		};
    eza = {
      enable = true;
    };
	};

}

