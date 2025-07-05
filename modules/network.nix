{ config, pkgs, userSettings, systemSettings, ... }:

{
  i18n = {
    defaultLocale = userSettings.locale;
    extraLocaleSettings = {
      LC_ADDRESS = userSettings.locale;
      LC_IDENTIFICATION = userSettings.locale;
      LC_MEASUREMENT = userSettings.locale;
      LC_MONETARY = userSettings.locale;
      LC_NAME = userSettings.locale;
      LC_NUMERIC = userSettings.locale;
      LC_PAPER = userSettings.locale;
      LC_TELEPHONE = userSettings.locale;
      LC_TIME = userSettings.locale;
    };
  };
  networking.hostName = systemSettings.hostName;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs ; [
    networkmanager
      networkmanagerapplet
  ];
}
