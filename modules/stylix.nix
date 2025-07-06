{ lib, pkgs, stylix, userSettings, systemSettings, ... }:
{
  stylix = {
# Theme configuration - uses the theme specified in userSettings
    image = ./../themes/${userSettings.theme}/background.png;
    base16Scheme = ./../themes/${userSettings.theme}/background.yaml;

# Font configuration for better readability and consistency
    fonts = {
# Monospace font for terminals and code editors
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "Meslo" ]; };
        name = "MesloLGS Nerd Font Mono";
      };
# Sans-serif font for UI elements
      sansSerif = {
        package = pkgs.nerdfonts.override { fonts = [ "Meslo" ]; };
        name = "MesloLGS Nerd Font";
      };
# Serif font for documents
      serif = {
        package = pkgs.nerdfonts.override { fonts = [ "Meslo" ]; };
        name = "MesloLGS Nerd Font";
      };
# Emoji font
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
