{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    lua-language-server
    nixd
    nixfmt-rfc-style
  ];
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  home.file.".config/nvim".source = ./config;
  home.file.".config/nvim".recursive = true;
}
