{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
  [ wayland waydroid
    (sddm-chili-theme.override {
     themeConfig = {
     background = config.stylix.image;
     ScreenWidth = 1920;
     ScreenHeight = 1080;
     blur = true;
     recursiveBlurLoops = 3;
     recursiveBlurRadius = 5;
     };})
  ];

# Configure xwayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };
  };
}

