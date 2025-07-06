{ config, pkgs, userSettings, systemSettings, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}/novanix";
  home.stateVersion = "25.05";

  home.packages = with pkgs ; [
    yafetch
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
