{
  pkgs, ...
}:
{
  home.packages = with pkgs; [ mc ];

  home.file = {
    ".local/share/mc/skins".source = ./skins;
    ".config/mc".source = ./config;
  };
}


