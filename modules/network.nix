{ config, pkgs, shared, ... }:

{
  i18n = {
    defaultLocale = shared.locale;
    extraLocaleSettings = {
      LC_ADDRESS = shared.locale;
      LC_IDENTIFICATION = shared.locale;
      LC_MEASUREMENT = shared.locale;
      LC_MONETARY = shared.locale;
      LC_NAME = shared.locale;
      LC_NUMERIC = shared.locale;
      LC_PAPER = shared.locale;
      LC_TELEPHONE = shared.locale;
      LC_TIME = shared.locale;
    };
  };
  networking.hostName = shared.hostName;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs ; [
    networkmanager
      networkmanagerapplet
  ];
}
