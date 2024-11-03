{ config, lib, pkgs, ...}:
{
  home.packages = with pkgs; [
    wezterm
  ];
  # LeftWM Specifics
  xdg.configFile = {
    "wezterm".source = ../../dotfiles/wezterm/.config/wezterm;
  };

  programs = {
    wezterm = {
      enable = true;
    };
  };
}
