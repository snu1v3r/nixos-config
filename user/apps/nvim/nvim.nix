{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    neovim
    neovide
    lua-language-server
  ];
  home.file.".config/nvim".source = ./.;
  home.file.".config/nvim".recursive = true;
}
