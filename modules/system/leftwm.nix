# ~/nixos-config/modules/home/hyprland.nix
{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.leftwm.enable = true;
    # Touchpad shenanigans
    libinput = {
      enable = true;
      touchpad = {
        tapping = false;
        naturalScrolling = true;
        disableWhileTyping = true;
        clickMethod = "clickfinger";
      };

    };
  };
  services.displayManager.sddm.enable = true;
  programs.dconf.enable = true;

  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
  };
}
