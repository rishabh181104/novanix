{
  description = "System configuration with centralized variables";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, stylix, ... } @ inputs:
    let
    shared = {
      hostName = "novanix";
      userName = "nova";
      system = "x86_64-linux";
      theme = "dracula";
      timeZone = "Asia/Kolkata";
      locale = "en_US.UTF-8";
    };
  lib = nixpkgs.lib;
  pkgs = nixpkgs.legacyPackages.${shared.system};
  in {
    nixosConfigurations.${shared.hostName} = nixpkgs.lib.nixosSystem {
      inherit (shared) system;
      specialArgs = { inherit shared inputs; };

      modules = [
        ./configuration.nix
          ./hardware.nix
          ./modules/stylix.nix
          stylix.nixosModules.stylix
      ];
    };
  };
}
