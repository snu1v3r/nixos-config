{ config, pkgs, userSettings, ... }:

{

  # The base configuration for the profile is taken from the `base/home.nix` file.
  # This file contains all modification that are needed to create a normal daily driver.

  imports = [
    ../base/home.nix # This creates the setup that is always needed
    ../../user/apps/flameshot/flameshot.nix
    ../../user/apps/plasma/plasma.nix
    ../../user/apps/codium/codium.nix
    ../../user/apps/${userSettings.browser} # This selects the terminal emulator
  ];

  home.packages = with pkgs; [ keepassxc ];

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
  };

  # This can be used to manage environment variables
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

}

