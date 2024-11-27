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
    lazygit = {
      enable = true;
      settings = {
        os = {
          edit = "/etc/profiles/per-user/user/bin/nvim {{filename}}";
          editAtLine = "/etc/profiles/per-user/user/bin/nvim {{filename}} +{{line}}";
        };
      };
    };
	};

}

