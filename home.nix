# ~/nixos-config/home.nix
{ config, pkgs, inputs, ... }:


{
	imports = [
	    ./modules/home/zsh.nix # TODO: Cleanup this mess
	    ./modules/home/neovim.nix # TODO: Not yet a 100% there
      #./modules/home/leftwm.nix
      ./modules/home/hyprland.nix # TODO: Not all keybindings are there yet
      ./modules/home/waybar.nix # TODO: This needs to be fixed up
      ./modules/home/wezterm.nix # TODO: Figure out how it works on wayland
      ./modules/home/fonts.nix
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
    firefox
    brave
    zoxide
    pcmanfm
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
  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
}
