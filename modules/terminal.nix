{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs ; [
    alacritty
      foot
      kitty
      btop
      bat
      bc
      brightnessctl
      ripgrep
      keychain
      wl-clipboard
      xclip
      gnome-keyring
      yafetch
      lazygit
      git
      psmisc
  ];
}
