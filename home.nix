# ~/nixos-config/home.nix
{ config, pkgs, ... }:

{
  home.username = "darko";  # Replace with your username
  home.homeDirectory = "/home/darko";  # Replace with your username

  home.packages = with pkgs; [
    ripgrep
    fd
    tree
  ];

  programs.git = {
    enable = true;
    userName = "Darko Mesaros";
    userEmail = "darko.subotica@gmail.comn";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#framework_laptop";  # Replace hostname
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };
  

  home.stateVersion = "24.05";
}
