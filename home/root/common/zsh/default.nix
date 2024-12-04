{
  lib,
  pkgs,
  userSettings,
  config,
  ...
}:
let
  myAliases = {
    cat = "bat";
    vi = "nvim";
    mc = "mc --nosubshell";
    saveclip = "xclip -selection clipboard -t image/png -o > ";
    lg = "lazygit";
    ls = "eza --icons=always";
    ll = "eza --long --icons=always --git";
    fzf = "fzf --tmux center";
    fzp = "fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'";
    fzv = "fzf --print0 | xargs -0 -o nvim";
    llt = "eza --tree --long --icons=always --git";
    lt = "eza --tree --icons=always";
    svi = "sudoedit";
    man = "batman";
    diff = "batdiff";
  };
in
{

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    sessionVariables = {

# The four lines below are disabled because of the more robust solution with batman (see ../bat/default.nix)
#      MANPAGER = (
#        if (config.programs.bat.enable == true) then "sh -c 'col -bx | bat -l man -p'" else "less"
#      );
#      MANROFFOPT = (if (config.programs.bat.enable == true) then "-c" else "");
      FZF_DEFAULT_OPTS = "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8,selected-bg:#45475a --multi";
    };
    plugins = lib.mkIf (userSettings.prompt == "p10k") [
      {
        name = "powerlevel10k-config";
        src = ./../p10k;
        file = "p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];
    #    initExtra = ( if (userSettings.prompt == "p10k") then
    #      ''
    #      source ~/nixos-config/dotfiles/p10k.zsh
    #      ''
    #    else
    #      ''
    #      ''
    #      );
  };
  programs.starship.enable = (if (userSettings.prompt == "starship") then true else false);
  programs.starship.enableZshIntegration = (
    if (userSettings.prompt == "starship") then true else false
  );
  programs.oh-my-posh.enable = (if (userSettings.prompt == "oh-my-posh") then true else false);
  programs.oh-my-posh.enableZshIntegration = (
    if (userSettings.prompt == "oh-my-posh") then true else false
  );

}
