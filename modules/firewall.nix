{ config, pkgs, ... }:

{
  networking.firewall.enable = true;
  # To open specific ports, use:
  # networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  # networking.firewall.allowedUDPPorts = [ ];
}
