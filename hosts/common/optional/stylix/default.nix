{
  config,
  pkgs,
  inputs,
  systemSettings,
  ...
}:

{
  stylix.enable = true;

  stylix.base16Scheme = ../../../../theming/colors/tokyonight.yaml;

  stylix.image = ../../../../theming/backgrounds/${systemSettings.hostname}.jpg;
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
      name = "JetBrainsMono Nerd Font Mono";
    };
    sizes = {
      applications = 10;
      terminal = 12;
      desktop = 10;
    };
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
}
