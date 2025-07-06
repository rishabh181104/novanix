{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.systemPackages = with pkgs ; [
    hyprland
    hypridle
    hyprland-qt-support
    hyprland-qtutils
    hyprlock
    hyprpicker
    pyprland
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
    waybar
    wlogout
    wlroots_0_19
    swww
    rose-pine-hyprcursor
    mako
    pavucontrol
    # QT6 packages
    qt6.qtbase
    qt6.qtsvg
    qt6.qtvirtualkeyboard
    qt6.qtmultimedia
    # Other utilities
    libsForQt5.xwaylandvideobridge
    xwayland-run
    imagemagick
    nwg-look
    fuzzel
    flat-remix-gtk
    papirus-icon-theme
    jamesdsp
  ];
}
