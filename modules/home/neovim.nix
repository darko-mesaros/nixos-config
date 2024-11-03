# ~/nixos-config/modules/home/neovim.nix
{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    
    # Install needed packages
    plugins = with pkgs.vimPlugins; [
      # Example plugins
      telescope-nvim
      nvim-treesitter
      lualine-nvim
      nvim-lspconfig
      # Add your plugins here
    ];

    # Install language servers, formatters, linters
    extraPackages = with pkgs; [
      # LSP servers
      nodePackages.typescript-language-server
      lua-language-server
      rust-analyzer
      # Formatters/Linters
      stylua
      nixfmt
      # Add more tools
    ];

    #Load your existing config files
    extraLuaConfig = ''
      -- Load your init.lua
      require('init')
    '';
  };

  # Option 2: Symlink your existing config files
  xdg.configFile = {
    "nvim" = {
      source = ./../../dotfiles/nvim;  # Path to your neovim config
      recursive = true;  # Include all subdirectories
    };
  };
}
