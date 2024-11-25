{ pkgs, ...}:

{
  programs.kitty = {
    font.name = "MesloLGS Nerd Font";
    themeFile = "Catppuccin-Mocha";
    enable = true;
    shellIntegration.enableZshIntegration = true;
  };

}
