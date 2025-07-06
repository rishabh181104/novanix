{
  description = "My NixOS Flake";

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let 
# ---- SYSTEM SETTINGS ---- #
    systemSettings = {
      system = "x86_64-linux";
      hostname = "novanix";
      timezone = "Asia/Kolkata";
      locale = "en_US.UTF-8";
      bootMode = "uefi";
      bootMountPath = "/boot";
      gpuType = "nvidia";
    };

# ----- USER SETTINGS ----- #
  userSettings = {
    username = "nova";
    name = "rishabh181104";
    email = "rishabhhaldiya18@gmail.com";
    dotfilesDir = "~/novanix";
    theme = "gruvbox-dark-hard";
    wm = "hyprland";
    browser = "brave";
    term = "alacritty";
    editor = "zeditor";
    timezone = "Asia/Kolkata";
    locale = "en_US.UTF-8";
  };

  lib = nixpkgs.lib;
  in {
    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./modules/home.nix
        ];
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
        };
      };
    };
    nixosConfigurations = {
      ${systemSettings.hostname} = lib.nixosSystem {
        system = systemSettings.system;
        modules = [
          ./configuration.nix
            inputs.stylix.nixosModules.stylix
        ];
        specialArgs = {
          inherit userSettings;
          inherit systemSettings;
          inherit inputs;
        };
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
