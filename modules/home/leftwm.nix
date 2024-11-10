{ config, lib, pkgs, ...}:
{
  home.packages = with pkgs; [
    dunst
    kitty
    rofi
    polybar
    autorandr
    xorg.xrandr
  ];
  # LeftWM Specifics
  xdg.configFile = {
    "leftwm/config.ron".source = ../../dotfiles/leftwm/.config/leftwm/config.ron;
    "leftwm/themes".source = ../../dotfiles/leftwm/.config/leftwm/themes;
  };


  programs = {
    kitty = {
      enable = true;
    };
    rofi = {
      enable = true;
    };
    autorandr = {
      enable = true;
      profiles = {
        "laptop-only" = {
          fingerprint = {
            eDP-1 = "00ffffffffffff0009e55f0900000000171d0104a51c137803de50a3544c99260f505400000001010101010101010101010101010101115cd01881e02d50302036001dbe1000001aa749d01881e02d50302036001dbe1000001a000000fe00424f452043510a202020202020000000fe004e4531333546424d2d4e34310a00fb";
          };
          config = {
            eDP-1 = {
              enable = true;
              mode = "2256x1504";
              position = "0x0";
              rate = "60.00";
              primary = true;
            };
          };
        };
        "gameroom-left" = {
          fingerprint = {
            eDP-1 = "00ffffffffffff0009e55f0900000000171d0104a51c137803de50a3544c99260f505400000001010101010101010101010101010101115cd01881e02d50302036001dbe1000001aa749d01881e02d50302036001dbe1000001a000000fe00424f452043510a202020202020000000fe004e4531333546424d2d4e34310a00fb";
            DP-1 = "00ffffffffffff001c5404320e000000311f0104b54627783be1b5ad5045a0250d5054bfcf00814081809500714f81c0b300d1c001014dd000a0f0703e8030203500b9882100001a000000ff003231343931423030303031340a000000fd003090ffff83010a202020202020000000fc004769676162797465204d3332550207020342f156010304131f120211900f0e1d1e60610514765d5e5f2f230907078301000065030c0020006d1a0000020b30900005653c653ce305c301e6060501656512565e00a0a0a0295030203500b9882100001a8a6f80a0703840403020280cb9882100001a6fc200a0a0a0555030203500b9882100001a0000000000000025701279000003016447f80104ff0e4f0007001f006f087e0070000700eba30104ff0e4f0007001f006f087e0070000700d0500104ff0e9f0010003e006f08270014000700fb7e00047f07870017001f003704110002000400f7e30004ff099f0007001f009f05310018000700000000000000000000000000000000000000d190";
          };
          config = {
            eDP-1 = {
              enable = true;
              mode = "2256x1504";
              position = "0x0";
              rate = "60.00";
              primary = false;
            };
            DP-1 = {
              enable = true;
              mode = "3840x2160";
              position = "2256x0";
              rate = "144.00";
              primary = true;
            };
          };
        };
      };
    };
  };

  #home.file.".config/leftwm".source = config.lib.file.mkOutOfStoreSymlink ./../../dotfiles/leftwm/.config/leftwm;
}
