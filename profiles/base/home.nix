{
  lib,
  config,
  pkgs,
  userSettings,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  imports = [
    ../../user/shell/zshell.nix
    ../../user/shell/cli-collection.nix
    (./. + "/../../user/apps" + ("/" + userSettings.emulator + "/" + userSettings.emulator) + ".nix") # This selects the terminal emulator
    ../../user/apps/zoxide/zoxide.nix
    ../../user/apps/starship
  ];

  home.packages = with pkgs; [ mc ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".local/share/mc/skins".source = ../../user/apps/mc/skins;
    ".config/mc".source = ../../user/apps/mc;
  };

  # This can be used to manage environment variables
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

  };
  programs.git = {
    enable = true;
    userEmail = "snu1v3r@github.com";
    userName = "snu1v3r";
  };

}
