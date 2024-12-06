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
  home.homeDirectory = lib.mkDefault "/home/${userSettings.username}";
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
    ../common/bat
    ../common/eza
    ../common/fzf
    ../common/git
    ../common/lazygit
    ../common/mc
    ../common/nvim
    ../common/tmux
    ../common/zoxide
    ../common/zsh
  ] ++
    lib.optionals (userSettings.prompt == "starship")
    [ ../common/starship ];

  # Possibly temporary for SOPS. If to many lines this should be moved to the imports above
#  home.packages = with pkgs; [
#    age
#  ];


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # This can be used to manage environment variables
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

}
