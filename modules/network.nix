{ config, pkgs, userSettings, systemSettings, ... }:

{
  i18n = {
    defaultLocale = systemSettings.locale;
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "C.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ADDRESS = systemSettings.locale;
      LC_IDENTIFICATION = systemSettings.locale;
      LC_MEASUREMENT = systemSettings.locale;
      LC_MONETARY = systemSettings.locale;
      LC_NAME = systemSettings.locale;
      LC_NUMERIC = systemSettings.locale;
      LC_PAPER = systemSettings.locale;
      LC_TELEPHONE = systemSettings.locale;
      LC_TIME = systemSettings.locale;
    };
  };
  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;
  # Optionally, use iwd for WiFi backend:
  # networking.networkmanager.wifi.backend = "iwd";
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs ; [
    networkmanager
  ];
}
