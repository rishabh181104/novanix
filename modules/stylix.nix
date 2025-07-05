{ lib, smsm, pkgs, stylix, ... }:
{
  stylix = {
# image = /home/${smsm.userName}/novanix/themes/${smsm.theme}/background.yaml;
# base16Scheme = /home/${smsm.userName}/novanix/themes/${smsm.theme}/background.png;
    image = ./../themes/${smsm.theme}/background.png;
    base16Scheme = ./../themes/${smsm.theme}/background.yaml;
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
