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
    smsm = {
      hostName = "novanix";
      userName = "nova";
      system = "x86_64-linux";
      theme = "dracula";
      timeZone = "Asia/Kolkata";
      locale = "en_US.UTF-8";
    };
  lib = nixpkgs.lib;
  pkgs = import nixpkgs {
    inherit (smsm) system;

    config = {
      allowUnfree = true;
    };
  };
  in {
    nixosConfigurations.${smsm.hostName} = nixpkgs.lib.nixosSystem {
      inherit (smsm) system;
      specialsmsm = { inherit (smsm) inputs; };

      modules = [
        ./configuration.nix
          stylix.nixosModules.stylix
      ];
    };
  };
}
