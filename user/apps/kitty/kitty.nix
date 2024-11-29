{ pkgs, ...}:

{
  programs.kitty = {
    enable = true;
# This option is disabled. It appears to cause key ghosting
#    shellIntegration.enableZshIntegration = true;
  };

}
