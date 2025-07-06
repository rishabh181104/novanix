{ config, pkgs, ... }:
{
  # Set nixpkgs.config.allowUnfree = true; globally in configuration.nix
# programs.firefox.enable = true;
  environment.systemPackages = with pkgs ; [
    google-chrome
      brave
  ];
}
