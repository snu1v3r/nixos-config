{
  lib,
  pkgs,
  config,
  userSettings,
  ...
}:

{
  config = lib.mkIf (userSettings.prompt == "starship") {
    programs.starship.enable = true;
    home.file.".config/starship.toml".source = ./catppucchin-mocha.toml;
  };
}
