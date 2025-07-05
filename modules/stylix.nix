{ lib, shared, pkgs, stylix, ... }:
{
  stylix = {
# image = /home/${shared.userName}/novanix/themes/${shared.theme}/background.yaml;
# base16Scheme = /home/${shared.userName}/novanix/themes/${shared.theme}/background.png;
    image = ./../themes/${shared.theme}/background.png;
    base16Scheme = ./../themes/${shared.theme}/background.yaml;
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
