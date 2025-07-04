{ config, pkgs, userSettings, ... }:

{
  programs.git.enable = true;
  programs.git.userName = userSettings.name;
  programs.git.userEmail = userSettings.email;
}
