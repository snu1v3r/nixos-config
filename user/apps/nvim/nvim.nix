{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [ lua-language-server nixd alejandra nixfmt ];
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  home.file.".config/nvim".source = ./.;
  home.file.".config/nvim".recursive = true;
}
