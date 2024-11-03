# ~/nixos-config/flake.nix
{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### Hardware Quirks ###
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    ### Neovim Plugins ###
    plugin-noctis-hc = {
      url = "github:iagorrr/noctis-high-contrast.nvim";
      flake = false;
    };
    ### END Neovim Plugins ###
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware,  plugin-noctis-hc, ... }:
    let
      system = "x86_64-linux";
      #pkgs = import nixpkgs {inherit system;};
      pkgs = nixpkgs.legacyPackages.${system};
      #lib = nixpkgs.lib;

      # Create a custom package for the plugin
      pluginNoctisHc = pkgs.vimUtils.buildVimPlugin {
        name = "noctis-hc";
        src = plugin-noctis-hc;
      };

      # Create an overlay to make the plugin available
      overlay = final: prev: {
        vimPlugins = prev.vimPlugins  // {
          noctis-hc = pluginNoctisHc;
        };
      };

      # Create the mopdified pkgs with our overlay
      pkgsWithPlugin = import nixpkgs {
        inherit system;
        overlays = [overlay];
      };
    in
    {
      nixosConfigurations = {
        # Replace hostname with your actual hostname
        framework_laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            ./hosts/framework_laptop
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.darko = import ./home.nix;  # Replace username

              # Make our modified pkgs available
              nixpkgs.overlays = [overlay];
            }
            # Hardware for the Framework laptop 13
            nixos-hardware.nixosModules.framework-12th-gen-intel
          ];
        };
      };
    };
}


