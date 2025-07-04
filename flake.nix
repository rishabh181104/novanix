{
  description = "System configuration with centralized variables";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... } @ inputs:
    let
      # Centralized configuration - define once, use everywhere
      shared = {
        hostName = "novanix";     # Change to your hostname
        userName = "nova";          # Change to your username
        system = "x86_64-linux";    # Change architecture if needed
        theme = "dracula";
        # wallpaper = ./themes/${theme}/background.png;
      };
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${shared.system};
    in {
      nixosConfigurations.${shared.hostName} = lib.nixosSystem {
        inherit (shared) system;
        specialArgs = { inherit shared inputs; };  # Make shared available in all modules

        modules = [
          ({ shared, ... }: { 
            networking.hostName = shared.hostName;
          })

          # Import your configuration files
          ./configuration.nix
          ./hardware.nix

          # Home Manager integration
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit shared inputs; };
              users.${shared.userName} = {
                imports = [ 
                  ./home.nix
                ];
              };
            };
          }

          # Stylix theming (uncomment when ready)
          # stylix.nixosModules.stylix
          # {
          #   stylix.image = shared.wallpaper;
          #   stylix.base16Scheme = ...;
          # }
        ];
      };
      
      # Standalone Home Manager configuration
      homeConfigurations.${shared.userName} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit shared; };
        modules = [ ./home.nix ];
      };
    };
}
