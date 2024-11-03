{ config, lib, pkgs, ...}:
{
  home.packages = with pkgs; [
    dunst
    kitty
    rofi
    polybar
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
  };

  #home.file.".config/leftwm".source = config.lib.file.mkOutOfStoreSymlink ./../../dotfiles/leftwm/.config/leftwm;
}
