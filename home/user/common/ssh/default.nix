{ ... }:

{
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
      };
    };
  };
}
