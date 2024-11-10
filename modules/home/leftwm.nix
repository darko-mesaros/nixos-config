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
      };
    };
  };

  #home.file.".config/leftwm".source = config.lib.file.mkOutOfStoreSymlink ./../../dotfiles/leftwm/.config/leftwm;
}
