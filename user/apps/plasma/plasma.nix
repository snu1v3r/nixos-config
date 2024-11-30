# https://nix-community.github.io/plasma-manager/options.xhtml
{ lib, pkgs, userSettings, ... }: {
  programs.plasma = {
    enable = true;
    fonts = {
      general = {
        family = "MesloLGS Nerd Font";
        pointSize = 10;
      };
    };
    kwin.virtualDesktops = {
      rows = 2;
      names = [ "Desktop 1" "Desktop 2" "Desktop 3" "Desktop 4" ];
    };
    shortcuts = {
      kwin = {
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
      };
      plasmashell = {
        "activate task manager entry 1" = "none";
        "activate task manager entry 2" = "none";
        "activate task manager entry 3" = "none";
        "activate task manager entry 4" = "none";
        "activate task manager entry 5" = "none";
        "activate task manager entry 6" = "none";
        "activate task manager entry 7" = "none";
        "activate task manager entry 8" = "none";
        "activate task manager entry 9" = "none";
        "activate task manager entry 10" = "none";
      };
      kwin = {
        "Window to Desktop 1" = "Alt+1";
        "Window to Desktop 2" = "Alt+2";
        "Window to Desktop 3" = "Alt+3";
        "Window to Desktop 4" = "Alt+4";
        "Window Maximize" = "Alt+Return";
        "Window Fullscreen" = "Alt+Shift+Return";
        "Window Quick Tile Bottom" = "Alt+Shift+Down";
        "Window Quick Tile Top" = "Alt+Shift+Up";
        "Window Quick Tile Left" = "Alt+Shift+Left";
        "Window Quick Tile Right" = "Alt+Shift+Right";
        "Window One Screen to the Left" = "Alt+Left";
        "Window One Screen to the Right" = "Alt+Right";
        "Switch Window Down" = "Meta+Shift+Down";
        "Switch Window Up" = "Meta+Shift+Up";
        "Switch Window Left" = "Meta+Shift+Left";
        "Switch Window Right" = "Meta+Shift+Right";

      };
      "org.flameshot.Flameshot.desktop"."Capture" = "Print";
    } // lib.optionalAttrs (userSettings.browser == "brave") { "services/brave-browser.desktop"."_launch" = "Meta+B";
    } // lib.optionalAttrs (userSettings.emulator == "kitty") {"services/kitty.desktop"."_launch" = "Meta+Return";
    } // lib.optionalAttrs (userSettings.emulator == "alacritty") {"services/Alacritty.desktop"."_launch" = "Meta+Return";
    };
  };
}
