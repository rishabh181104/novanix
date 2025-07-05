{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs ; [ 
    blueman
    bluez
    bluez-tools
  ];
}
