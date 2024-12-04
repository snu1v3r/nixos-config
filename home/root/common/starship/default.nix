 
{ ... }:

{
  config = {
    programs.starship.enable = true;
    home.file.".config/starship.toml".source = ./catppucchin-mocha.toml;
  };
}
