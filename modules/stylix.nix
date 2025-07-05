{ lib, pkgs, stylix, userSettings, systemSettings, ... }:
{
  stylix = {
# image = /home/${userSettings.userName}/novanix/themes/${userSettings.theme}/background.yaml;
# base16Scheme = /home/${userSettings.userName}/novanix/themes/${userSettings.theme}/background.png;
    image = ./../themes/${userSettings.theme}/background.png;
    base16Scheme = ./../themes/${userSettings.theme}/background.yaml;
    fonts = {
# monospace = {
#   package = pkgs.nerdfonts.override { fonts = [ "Meslo" ]; };
#   name = "MesloLGS Nerd Font Mono";
# };
# sansSerif = {
#   package = pkgs.nerdfonts.override { fonts = [ "Meslo" ]; };
#   name = "MesloLGS Nerd Font";
# };
# serif = {
#   package = pkgs.nerdfonts.override { fonts = [ "Meslo" ]; };
#   name = "MesloLGS Nerd Font";
# };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
