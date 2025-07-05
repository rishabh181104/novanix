{ lib, sargs, pkgs, stylix, ... }:
{
  stylix = {
# image = /home/${sargs.userName}/novanix/themes/${sargs.theme}/background.yaml;
# base16Scheme = /home/${sargs.userName}/novanix/themes/${sargs.theme}/background.png;
    image = ./../themes/${sargs.theme}/background.png;
    base16Scheme = ./../themes/${sargs.theme}/background.yaml;
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
