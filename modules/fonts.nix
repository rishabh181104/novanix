{ config, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    meslo-lgs-nf
      font-awesome
      nerd-fonts.dejavu-sans-mono
      noto-fonts-emoji
      nerd-fonts
  ];
}
