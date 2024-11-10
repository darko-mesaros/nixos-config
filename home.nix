# ~/nixos-config/home.nix
{ config, pkgs, inputs, ... }:


{
	imports = [
	    ./modules/home/zsh.nix # TODO: Cleanup this mess
	    ./modules/home/neovim.nix 
      ./modules/home/leftwm.nix
    #./modules/home/hyprland.nix # TODO: Not all keybindings are there yet
    #./modules/home/waybar.nix # TODO: This needs to be fixed up
      ./modules/home/wezterm.nix # TODO: Figure out how it works on wayland
      ./modules/home/chat.nix # TODO: Configure IRC if needed
      ./modules/home/internet.nix
      ./modules/home/fonts.nix
      ./modules/home/style.nix
      ./modules/home/security.nix
    ];

    home = {
      username = "darko";  # Replace with your username
      homeDirectory = "/home/darko";  # Replace with your username
      packages = with pkgs; [
        ripgrep
        fd
        tree
        figlet
        lolcat
        eza
        ranger
        zoxide
        lazygit
        # GUI # TODO: Figure out how to evaluate this on SSH only systems
        firefox
        brave
      pcmanfm
      ];
    };

  # Global Program configurations - this will likely go somewhere else
  programs = { 
    git = {
      enable = true;
      userName = "Darko Mesaros";
      userEmail = "darko.subotica@gmail.comn";
    };
    bash = {
      enable = true;
      shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#framework_laptop";  # Replace hostname
      };
    };
    home-manager.enable = true;
  };

  home.stateVersion = "24.05";
}
