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
    sargs = {
      hostName = "novanix";
      userName = "nova";
      system = "x86_64-linux";
      theme = "dracula";
      timeZone = "Asia/Kolkata";
      locale = "en_US.UTF-8";
    };
  lib = nixpkgs.lib;
  pkgs = import nixpkgs {
    inherit (sargs) system;

    config = {
      allowUnfree = true;
    };
  };
  in {
    nixosConfigurations.${sargs.hostName} = nixpkgs.lib.nixosSystem {
      inherit (sargs) system;
      specialsargs = { inherit (sargs) inputs; };

      modules = [
        ./configuration.nix
          stylix.nixosModules.stylix
      ];
    };
  };
}
