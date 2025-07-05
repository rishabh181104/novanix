{ lib, env, pkgs, stylix, ... }:
{
  stylix = {
# image = /home/${env.userName}/novanix/themes/${env.theme}/background.yaml;
# base16Scheme = /home/${env.userName}/novanix/themes/${env.theme}/background.png;
    image = ./../themes/${env.theme}/background.png;
    base16Scheme = ./../themes/${env.theme}/background.yaml;
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
