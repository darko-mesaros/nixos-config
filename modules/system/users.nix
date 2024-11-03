# ~/nixos-config/modules/system/users.nix
{ config, pkgs, ... }:

{
  users.users.darko = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel" 
      "networkmanager"
      # Add more groups as needed
    ];
    # You can add more user-specific settings here
    shell = pkgs.zsh;
    # hashedPassword = "...";
  };

  # You can add more users here
  # users.users.anotheruser = { ... };

  # User-related system configurations
  security.sudo.wheelNeedsPassword = true;  # Example setting
  programs.zsh.enable = true;  # Enable if using fish shell
}
