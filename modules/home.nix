{ config, pkgs, userSettings, systemSettings, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    yafetch
  ];

  home.file = {
  };

  home.sessionVariables = {
# Ensure proper environment variables for Wayland
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland";
    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    MOZ_ENABLE_WAYLAND = "1";
# NVIDIA specific variables
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __NV_PRIME_RENDER_OFFLOAD = "1";
  };

# Enable Stylix for home-manager
  stylix = {
    enable = true;
    image = ./../themes/${userSettings.theme}/background.png;
    base16Scheme = ./../themes/${userSettings.theme}/background.yaml;

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

    autoEnable = true;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };

# Configure GTK and Qt theming
  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
  };

  programs.home-manager.enable = true;
}
