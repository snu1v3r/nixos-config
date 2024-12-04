{ userSettings, ... }:
{
  imports = [
    ../core
    ../common/codium
    ../common/${userSettings.browser}
    ../common/${userSettings.emulator} # This selects the terminal emulator
  ];
}

