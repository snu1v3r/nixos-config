# This an overview of packages that are needed for cross compilation for Havoc
# nix-shell -p pkgsCross.mingw32.buildPackages.gcc pkgsCross.mingwW64.buildPackages.gcc

{
  pkgs,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
  lib,
  python310,

}:

buildGoModule rec {
  pname = "Havoc";
  version = "0.7.1";
  #  src = fetchFromGitHub {
  #    owner = "snu1v3r";
  #    repo = "Havoc_Nightmare";
  #    tag = "main";
  #    #tag = "v${version}";
  #    #
  #    sha256 = "sha256-Helm7XqZ+CU/tRm4p0Le5kIbI7Vl5S4jDvQwKkMDkAo=";
  #  };

  src = ./Havoc_Nightmare;

  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  #  dontUseCmakeConfigure = true;

  #  goDeps = teamserver/go.mod;
  #  proxyVendor = false;

  #  buildPhase = ''
  #   cd $src/teamserver
  # GO111MODULE="on"
  #  go build -ldflags="-s -w -X cmd.VersionCommit=test" -o $out/havoc main.go
  # '';

  preConfigure = ''
    cd teamserver
  '';

  preBuild = ''
    cd teamserver
  '';
  buildPhase = ''
    GO111MODULE="on"
    go build -ldflags="-s -w -X cmd.VersionCommit=test" -o havoc main.go
    #make dev-ts-compile
    #    mkdir -p $out/profiles
    mkdir -p $out/bin
    cp havoc $out/bin/havoc
  '';

  installPhase = ''
    mkdir -p $out/share/havoc/profiles
    cp -r $src/payloads $out/share/havoc/payloads
    sed '/^\s*\(Nasm\|Compiler\)\(64\|86\|\)\s=\s/s/\".*\"/""/' $src/profiles/havoc.yaotl > $out/share/havoc/profiles/havoc.yaotl
    cp $src/client/config.toml $out/share/havoc/profiles
    cp -r $src/client/Modules $out/share/havoc/modules
  '';

  postFixup = ''
    wrapProgram $out/bin/havoc --suffix PATH : ${
      pkgs.lib.makeBinPath (
        with pkgs;
        [
          nasm
          pkgsCross.mingw32.buildPackages.gcc
          pkgsCross.mingwW64.buildPackages.gcc
        ]
      )
    }
  '';
  vendorHash = "sha256-uxlZXqucTMavrtW5nB1P69XVu6668nh6k4S0BTiwgn4=";

  meta = with lib; {
    desciption = "My Havoc Framework";
    homepage = "https://github.com/snu1v3r/Havoc_Nightmare";
    platforms = platforms.unix;
  };
}
