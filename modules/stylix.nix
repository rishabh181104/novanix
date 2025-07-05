{ lib, shared, pkgs, ... }:
{
  stylix = {
    image = /home/${shared.userName}/novanix/themes/${shared.theme}/background.yaml;
    base16Scheme = /home/${shared.userName}/novanix/themes/${shared.theme}/background.png;
    polarity = "dark";  # or "light"
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
  };
}
