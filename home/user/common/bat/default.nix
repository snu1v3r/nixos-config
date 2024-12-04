{ pkgs, ...}:

{
  programs.bat = {
    enable = true;
    config = {
#      style = "numbers,changes,header";
    };
    extraPackages = builtins.attrValues {
      inherit (pkgs.bat-extras)

      batgrep
      batdiff
      batman
      ;
    };
  };
}

