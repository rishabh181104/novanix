{ config, pkgs, refrence, ... }:

{
  i18n = {
    defaultLocale = refrence.locale;
    extraLocaleSettings = {
      LC_ADDRESS = refrence.locale;
      LC_IDENTIFICATION = refrence.locale;
      LC_MEASUREMENT = refrence.locale;
      LC_MONETARY = refrence.locale;
      LC_NAME = refrence.locale;
      LC_NUMERIC = refrence.locale;
      LC_PAPER = refrence.locale;
      LC_TELEPHONE = refrence.locale;
      LC_TIME = refrence.locale;
    };
  };
  networking.hostName = refrence.hostName;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs ; [
    networkmanager
      networkmanagerapplet
  ];
}
