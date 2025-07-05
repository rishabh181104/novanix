{ config, pkgs, env, ... }:

{
  i18n = {
    defaultLocale = env.locale;
    extraLocaleSettings = {
      LC_ADDRESS = env.locale;
      LC_IDENTIFICATION = env.locale;
      LC_MEASUREMENT = env.locale;
      LC_MONETARY = env.locale;
      LC_NAME = env.locale;
      LC_NUMERIC = env.locale;
      LC_PAPER = env.locale;
      LC_TELEPHONE = env.locale;
      LC_TIME = env.locale;
    };
  };
  networking.hostName = env.hostName;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs ; [
    networkmanager
      networkmanagerapplet
  ];
}
