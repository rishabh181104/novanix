{ config, pkgs, smsm, ... }:

{
  i18n = {
    defaultLocale = smsm.locale;
    extraLocaleSettings = {
      LC_ADDRESS = smsm.locale;
      LC_IDENTIFICATION = smsm.locale;
      LC_MEASUREMENT = smsm.locale;
      LC_MONETARY = smsm.locale;
      LC_NAME = smsm.locale;
      LC_NUMERIC = smsm.locale;
      LC_PAPER = smsm.locale;
      LC_TELEPHONE = smsm.locale;
      LC_TIME = smsm.locale;
    };
  };
  networking.hostName = smsm.hostName;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs ; [
    networkmanager
      networkmanagerapplet
  ];
}
