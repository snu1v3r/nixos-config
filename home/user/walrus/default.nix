{ userSettings, ... }:
{
  imports = [
    ../core
    ../common/codium
    ../common/flameshot
    ../common/plasma
    ../common/${userSettings.browser}
    ../common/${userSettings.emulator} # This selects the terminal emulator
    ../common/nextcloud-client
  ];
}
