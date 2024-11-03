# ~/nixos-config/modules/home/hyprland.nix
{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  environment.systemPackages = [
    pkgs.waybar
    # Waybar
    (pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    }))
    pkgs.dunst
    pkgs.swww
    pkgs.kitty
    pkgs.wezterm
    pkgs.rofi-wayland
    pkgs.rofimoji
  ];
}
