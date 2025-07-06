{ config, pkgs, userSettings, ... }:
{

  services = {
    displayManager = {
      defaultSession = "hyprland";
      autoLogin = {
        enable = true;
        user = userSettings.username;
      };
    };
  };
}

