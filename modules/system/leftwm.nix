# ~/nixos-config/modules/home/hyprland.nix
{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.leftwm.enable = true;
  };
  services.displayManager.sddm.enable = true;

  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
  };
}
