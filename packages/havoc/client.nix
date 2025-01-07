# This an overview of packages that are needed for cross compilation for Havoc
# nix-shell -p pkgsCross.mingw32.buildPackages.gcc pkgsCross.mingwW64.buildPackages.gcc

{
  pkgs,
  stdenv,
  fetchFromGitHub,
  lib,
  go,
  git,
}:

stdenv.mkDerivation rec {
  pname = "havoc-client";
  version = "0.0.1";
  #  src = fetchFromGitHub {
  #    owner = "snu1v3r";
  #    repo = "Havoc_Nightmare";
  #    tag = "main";
  #    #tag = "v${version}";
  #    #
  #    sha256 = "sha256-Helm7XqZ+CU/tRm4p0Le5kIbI7Vl5S4jDvQwKkMDkAo=";
  #  };

  src = ./Havoc_Nightmare/client;
  dontWrapQtApps = false;
  dontPatchELF = true;

  # Needed at runtime
  buildInputs = with pkgs; [
    xorg.libX11
    xorg.libXi
    xorg.libxcb.dev
    xorg.xcbutil
    python310
    git
    mesa
    libsForQt5.qt5.wrapQtAppsHook
    qt5.full
    go
  ];

  # Needed at build time
  nativeBuildInputs = with pkgs; [
    cmake
    libsForQt5.qt5.wrapQtAppsHook
    xorg.libX11
    xorg.libXi
    xorg.libxcb.dev
    xorg.xcbutil
    python310
    git
    mesa
    qt5.full
    makeWrapper
    go
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp /build/client/Havoc $out/bin/havoc-client
  '';
  vendorHash = lib.fakeHash;

  meta = with lib; {
    desciption = "My Havoc Framework";
    homepage = "https://github.com/snu1v3r/Havoc_Nightmare";
    platforms = platforms.unix;
  };
}
