# ~/nixos-config/configuration.nix
{ config, pkgs, ... }:

{
  imports = [
    ./modules/system/users.nix
    ./modules/system/hyprland.nix
    #./modules/system/leftwm.nix
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Networking
  networking.networkmanager.enable = true;

  # Basic system-wide configuration
  time.timeZone = "US/Pacific";  # Change this
  i18n.defaultLocale = "en_US.UTF-8";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };


  # Basic system packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
    htop
    btop
    direnv
    elinks
    w3m
    pavucontrol
  ];

  # Enable services
  services.openssh.enable = true;
  # Lorri for nix-shell
  services.lorri.enable = true;

  # Create symlink for rebuilding
  system.activationScripts.flake-link = ''
    ln -sf /home/darko/nixos-config/flake.nix /etc/nixos/flake.nix
  '';

  system.stateVersion = "24.05";
}

