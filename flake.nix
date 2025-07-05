{
  description = "FLAKE FOR NOVA";

  outputs = inputs@{ self,nixpkgs, ... }:
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

  pkgs-unstable = import inputs.nixpkgs-patched {
    system = systemSettings.system;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
    overlays = [ inputs.rust-overlay.overlays.default ];
  };

  lib = nixpkgs.lib;

# Systems that can run tests:
  supportedSystems = [ "aarch64-linux" "i686-linux" "x86_64-linux" ];

# Function to generate a set based on supported systems:
  forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;

# Attribute set of nixpkgs for each system:
  nixpkgsFor =
    forAllSystems (system: import inputs.nixpkgs { inherit system; });
  in {

    nixosConfigurations = {
      system = lib.nixosSystem {
        system = systemSettings.system;
        modules = [
          ./configuration.nix
        ]; # load configuration.nix from selected PROFILE
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
        };
      };
    };
    packages = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};
        in {
        default = self.packages.${system}.install;

        install = pkgs.writeShellApplication {
        name = "install";
        runtimeInputs = with pkgs; [ git ]; # I could make this fancier by adding other deps
        text = ''${./install.sh} "$@"'';
        };
        });

    inputs = {
      nixpkgs.url = "nixpkgs/nixos-unstable";
      stylix = {
        url = "github:danth/stylix";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
  };
}
