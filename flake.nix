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

  outputs = { self, nixpkgs, home-manager, stylix, ... }:
    let
# Centralized configuration - define once, use everywhere
    shared = {
      hostName = "novanix";     # Change to your hostname
        userName = "nova";          # Change to your username
        system = "x86_64-linux";    # Change architecture if needed
        theme = "dracula";
# wallpaper = (./themes + theme + /background.png);
    };
    lib = nixpkgs.lib;
    inputs = nixpkgs.inputs;
    pkgs = nixpkgs.legacyPackages.${shared.system};
  in {
    nixosConfigurations.${shared.hostName} = nixpkgs.lib.nixosSystem {
      inherit (shared) system;
      specialArgs = { inherit shared inputs; };  # Make shared available in all modules

        modules = [
        ({ shared, ... }: { 
         networking.hostName = shared.hostName;
         })

# Home Manager integration
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit shared inputs; };  # Pass to Home Manager
            users.${shared.userName} = {
              imports = [ 
              ./home.nix
              ];
            };
        };
      }
      ];
      };
      
      # Standalone Home Manager configuration
      homeConfigurations.${shared.userName} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit shared; };
        modules = [ ./home.nix ];
      };

# Stylix theming
# stylix.nixosModules.stylix
# {
#   stylix = {
#     image = shared.wallpaper;
#     base16Scheme = ...;  # Define theme if desired
#       ... other Stylix config ...
#   };
# }
  };
}
