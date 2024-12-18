# ~/nixos-config/hosts/framework_laptop/default.nix
{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Host-specific configuration
  networking.hostName = "fraxos";  # Replace with your hostname
  
  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # BIOS Updates
  services = {
    fwupd.enable = true;
    fprintd.enable = true;
    #fprintd.tod.enable = true;
    power-profiles-daemon.enable = true;
  };

  # Host-specific packages or services
  environment.systemPackages = with pkgs; [
    # Add host-specific packages here
    brightnessctl
  ];
}
