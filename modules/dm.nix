{ config, pkgs, userSettings, ... }:
{

  services = {
# Ensure proper display manager
    displayManager = {
      defaultSession = "hyprland";
      autoLogin = {
        enable = true;
        user = userSettings.username;
      };
    };
  };
}

