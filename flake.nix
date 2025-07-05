{
  description = "FLAKE FOR NOVA";

  outputs = inputs@{ self,nixpkgs,stylix, ... }:
    let
# ---- SYSTEM SETTINGS ---- #
    systemSettings = {
      system = "x86_64-linux";
      hostname = "novanix";
      timezone = "Asia/Kolkata";
      locale = "en_IN.UTF-8";
      bootMode = "uefi";
      bootMountPath = "/boot";
      grubDevice = "";
      gpuType = "nvidia";
    };

# ----- USER SETTINGS ----- #
  userSettings = rec {
    username = "nova";
    name = "Rishabh";
    email = "rishabhhaldiya18@gmail.com";
    dotfilesDir = "~/novanix";
    theme = "dracula";
    wm = "hyprland";
    wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
    browser = "brave";
    term = "alacritty";
    font = "MesloLGS Nerd Font Mono";
    editor = "zen-editor";
  };
  lib = nixpkgs.lib;
  supportedSystems = [ "x86_64-linux" ];
  in {
    nixosConfigurations = {
      system = lib.nixosSystem {
        system = systemSettings.system;
        modules = [
          ./configuration.nix
            stylix.nixosSystem.stylix
        ];
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
        };
      };
    };
  };
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
