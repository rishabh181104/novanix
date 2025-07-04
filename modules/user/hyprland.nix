{ pkgs, home-manager, lib, ... }:
{
# Security
  security = {
    pam.services.login.enableGnomeKeyring = true;
  };

# Note: gnome-keyring is installed as a package in home.nix
# The service is not needed for basic functionality

  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };
  };

  services.xserver = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      theme = "chili";
      package = pkgs.sddm;
    };
  };
}
