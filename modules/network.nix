{ config, pkgs, spec, ... }:

{
  i18n = {
    defaultLocale = spec.locale;
    extraLocaleSettings = {
      LC_ADDRESS = spec.locale;
      LC_IDENTIFICATION = spec.locale;
      LC_MEASUREMENT = spec.locale;
      LC_MONETARY = spec.locale;
      LC_NAME = spec.locale;
      LC_NUMERIC = spec.locale;
      LC_PAPER = spec.locale;
      LC_TELEPHONE = spec.locale;
      LC_TIME = spec.locale;
    };
  };
  networking.hostName = spec.hostName;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs ; [
    networkmanager
      networkmanagerapplet
  ];
}
