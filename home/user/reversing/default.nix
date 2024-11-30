{ pkgs, ... }:
{
  imports = [
  ../core
  ];
  home.packages = with pkgs; [
    ida-free
    ghidra
    radare2
    pwndbg
  ];

}

