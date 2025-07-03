{
  description = "Flake for Nova";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, stylix, ... }:
    let 
    lib = nixpkgs.lib;
  system = "x86_64-linux";

## ----- System Settings ---- ##
  systemSettings = {
    inherit system;
    hostname = "nova";
    timezone = "Asia/Kolkata";
    locale = "en_IN.UTF-8";
    bootMode = "uefi";
    bootMountPath = "/boot";
    gpuType = "nvidia";
  };

## ---- User Settings ---- ##
  userSettings = rec {
    username = "ste";
    name = "Rishabh";
    email = "rishabhhaldiya18@gmail.com";
    dotfilesDir = "~/novanix";
    theme = "io";
    wm = "hyprland";
    wmType = if (( wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
    browser = "brave";
    term = "alacritty";
    font = "MesloLGS Nerd Font Mono";
    fontPkg = pkgs.meslo-lgs-nf;
    editor = "zeditor";
  };

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  in {
# Home Manager configuration
    homeConfigurations."${userSettings.username}" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home-manager/home.nix  # Your home-manager configuration
          stylix.homeModules.stylix
      ];
      extraSpecialArgs = {
        inherit inputs systemSettings userSettings;
      };
    };

# NixOS configuration
    nixosConfigurations.nova = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs systemSettings userSettings; };
      modules = [
        ./configuration.nix  # Your system configuration
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${userSettings.username} = {
              imports = [
                ./home-manager/home.nix
                  stylix.homeModules.stylix
              ];
            };
          }
      stylix.nixosModules.stylix
      ];
    };
  };
}
