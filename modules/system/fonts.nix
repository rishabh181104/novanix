{ pkgs, ... }:
{
# Fonts are nice to have
  fonts.packages = with pkgs; [
    meslo-lgs-nf
      font-awesome
      nerd-fonts.dejavu-sans-mono
  ];
}
