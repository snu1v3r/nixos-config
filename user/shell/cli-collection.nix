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
        gui.theme = {
          activeBorderColor = [ "#89b4fa" "bold" ];
          inactiveBorderColor = [ "#a6adc8" ];
          optionTextColor = [ "#89b4fa" ];
          selectedLineBgColor = [ "#313244" ];
          cherryPikcedCommitBgColor = [ "#45475a" ];
          cherryPikcedCommitFgColor = [ "#89b4fa" ];
          unstagedChangesColor = [ "#f38ba8" ];
          defaultFgColor = [ "#cdd6f4" ];
          searchingActiveBorderColor = [ "#f9e2af" ];
        };
        os = {
          edit = "/etc/profiles/per-user/user/bin/nvim {{filename}}";
          editAtLine = "/etc/profiles/per-user/user/bin/nvim {{filename}} +{{line}}";
        };
      };
    };
	};

}

