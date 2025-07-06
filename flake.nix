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
  userSettings = rec {
    username = "nova";
    name = "rishabh181104";
    email = "rishabhhaldiya18@gmail.com";
    dotfilesDir = "~/novanix";
    theme = "gruvbox-dark-hard";
    wm = "hyprland";
    wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
    browser = "brave";
    term = "alacritty";
    editor = "neovide";
  };
  in {
    nixosConfigurations = {
      ${systemSettings.hostname} = nixpkgs.lib.nixosSystem {
        system = systemSettings.system;
        modules = [
          ./configuration.nix
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                users.${userSettings.username} = import .modules/home.nix;
              };
            }
        ];
        specialArgs = {
          userSettings = userSettings;
          systemSettings = systemSettings;
          stylix = stylix;
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
