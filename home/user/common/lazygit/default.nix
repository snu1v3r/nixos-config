{ pkgs, ...}:

{
  programs.lazygit = {
    enable = true;
    settings = {
      os = {
        edit = "/etc/profiles/per-user/user/bin/nvim {{filename}}";
        editAtLine = "/etc/profiles/per-user/user/bin/nvim {{filename}} +{{line}}";
      };
    };
  };
}

