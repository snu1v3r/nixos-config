{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      ms-python.python
      ms-python.debugpy
      ms-python.pylint
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      vscodevim.vim
      ms-vscode-remote.remote-ssh
    ];
  };
}

