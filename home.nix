{ pkgs, userSettings, systemSettings, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = systemSettings.hostname;
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
