{ lib, refrence, pkgs, stylix, ... }:
{
  stylix = {
# image = /home/${refrence.userName}/novanix/themes/${refrence.theme}/background.yaml;
# base16Scheme = /home/${refrence.userName}/novanix/themes/${refrence.theme}/background.png;
    image = ./../themes/${refrence.theme}/background.png;
    base16Scheme = ./../themes/${refrence.theme}/background.yaml;
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
