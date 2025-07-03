{
  description = "Flake for Nova";

  outputs = inputs@{ self , ... }:
    let 

## ----- System Settings ---- ##
    systemSettings = {
      system = "x86_64-linux";
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

  in {
    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };

    nixosConfigurations = {
      system = lib.nixosSystem {
        system = systemSettings.system;
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
  };

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
}
