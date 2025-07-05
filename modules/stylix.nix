{ lib, spec, pkgs, stylix, ... }:
{
  stylix = {
# image = /home/${spec.userName}/novanix/themes/${spec.theme}/background.yaml;
# base16Scheme = /home/${spec.userName}/novanix/themes/${spec.theme}/background.png;
    image = ./../themes/${spec.theme}/background.png;
    base16Scheme = ./../themes/${spec.theme}/background.yaml;
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
