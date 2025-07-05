{ config, pkgs, ... }:

{
  xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    windowManager.qtile.enable = true;
    displayManager.sessionCommands = ''
      xrandr --output eDP-1 --mode "1920x1080" --rate "60.01"
      xrandr --output eDP-2 --mode "1920x1080" --rate "60.01"
      xrandr --output eDP-3 --mode "1920x1080" --rate "60.01"
      xrandr --output eDP-4 --mode "1920x1080" --rate "60.01"
      xrandr --output HDMI-1 --mode "1920x1080" --rate "60.01"
      xrandr --output HDMI-2 --mode "1920x1080" --rate "60.01"
      xrandr --output HDMI-3 --mode "1920x1080" --rate "60.01"
      xrandr --output HDMI-4 --mode "1920x1080" --rate "60.01"
      xwallpaper --zoom ~/Wallpapers/Pictures/Concept-Japanese\ house.png
      xset r rate 200 35 &
      '';
  };
  environment.systemPackages = with pkgs ; [
    python313Packages.qtile-extras
      xwallpaper
      xfce.thunar
      vlc
      mupdf
  ];
}
