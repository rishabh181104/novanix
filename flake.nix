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
        username = "nova";          # Change to your username
        system = "x86_64-linux";    # Change architecture if needed
        theme = "dracula";
# wallpaper = (./themes + theme + /background.png);
    };
  in {
    nixosConfigurations.${shared.hostName} = nixpkgs.lib.nixosSystem {
      inherit (shared) system;
      specialArgs = { inherit shared; };  # Make shared available in all modules

        modules = [
# Main system configuration (pass shared to it)
        ({ shared, ... }: { 
         networking.hostName = shared.hostName;
# ... other config using shared ...
         })

# Home Manager integration
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit shared; };  # Pass to Home Manager
            users.${shared.username} = {
              imports = [ ./home.nix ];
# Home Manager options here...
            };
        };
      }

# Stylix theming
# stylix.nixosModules.stylix
# {
#   stylix = {
#     image = shared.wallpaper;
#     base16Scheme = ...;  # Define theme if desired
#       ... other Stylix config ...
#   };
# }
      ];
    };
  };
}
