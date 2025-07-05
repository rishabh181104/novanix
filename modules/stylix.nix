{ lib, shared, pkgs, ... }:
{
  stylix = {
    image = shared.wallpaper;
    base16Scheme = shared.schemeFile;
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
