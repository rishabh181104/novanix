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
    refrence {
      hostName = "novanix";
      userName = "nova";
      system = "x86_64-linux";
      theme = "dracula";
      timeZone = "Asia/Kolkata";
      locale = "en_US.UTF-8";
    };
  lib = nixpkgs.lib;
  pkgs = import nixpkgs {
    inherit (refrence) system;

    config = {
      allowUnfree = true;
    };
  };
  in {
    nixosConfigurations.${refrence.hostName} = nixpkgs.lib.nixosSystem {
      inherit (refrence) system;
      specialArgs = { inherit (refrence) inputs; };

      modules = [
        ./configuration.nix
          stylix.nixosModules.stylix
      ];
    };
  };
}
