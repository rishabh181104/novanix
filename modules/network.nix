{ config, pkgs, sargs, ... }:

{
  i18n = {
    defaultLocale = sargs.locale;
    extraLocaleSettings = {
      LC_ADDRESS = sargs.locale;
      LC_IDENTIFICATION = sargs.locale;
      LC_MEASUREMENT = sargs.locale;
      LC_MONETARY = sargs.locale;
      LC_NAME = sargs.locale;
      LC_NUMERIC = sargs.locale;
      LC_PAPER = sargs.locale;
      LC_TELEPHONE = sargs.locale;
      LC_TIME = sargs.locale;
    };
  };
  networking.hostName = sargs.hostName;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs ; [
    networkmanager
      networkmanagerapplet
  ];
}
