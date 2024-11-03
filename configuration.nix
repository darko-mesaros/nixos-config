# ~/nixos-config/configuration.nix
{ config, pkgs, ... }:

{
  imports = [
    ./modules/system/users.nix
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

  # Basic system-wide configuration
  time.timeZone = "US/Pacific";  # Change this
  i18n.defaultLocale = "en_US.UTF-8";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Basic system packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
    htop
    btop
    direnv
  ];

  # Enable services
  services.openssh.enable = true;
  # Lorri for nix-shell
  services.lorri.enable = true;

  # Create symlink for rebuilding
  system.activationScripts.flake-link = ''
    ln -sf /home/darko/nixos-config/flake.nix /etc/nixos/flake.nix
  '';

  system.stateVersion = "24.11";
}

