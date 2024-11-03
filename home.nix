# ~/nixos-config/home.nix
{ config, pkgs, inputs, ... }:


{
	imports = [
	    ./modules/home/neovim.nix
	];
  home.username = "darko";  # Replace with your username
  home.homeDirectory = "/home/darko";  # Replace with your username

  home.packages = with pkgs; [
    ripgrep
    fd
    tree
    figlet
    lolcat
    eza
    ranger
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
  programs.zsh = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#framework_laptop";  # Replace hostname
      ll = "eza -l";
      l = "eza -la";
      ls = "eza";
    };
    initExtra = ''
      eval "$(direnv hook zsh)"
    '';

  };
  programs.home-manager.enable = true;

  

  home.stateVersion = "24.11";
}
