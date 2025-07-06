{ config, pkgs, ... }:
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
}

