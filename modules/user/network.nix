{ config, pkgs, hostName, ... }:

{
  networking.hostName = hostName;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
} 

