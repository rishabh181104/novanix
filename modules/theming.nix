{ config, pkgs, userSettings, ... }:
let
themePath = ./../themes/${userSettings.theme};
in
{
  stylix = {
    image = themePath + "/background.png";
    base16Scheme = themePath + "/background.yaml";

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "Meslo" ]; };
        name = "MesloLGS Nerd Font Mono";
      };

      sansSerif = {
        package = pkgs.nerdfonts.override { fonts = [ "Meslo" ]; };
        name = "MesloLGS Nerd Font";
      };

      serif = {
        package = pkgs.nerdfonts.override { fonts = [ "Meslo" ]; };
        name = "MesloLGS Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    autoEnable = true;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };
}
