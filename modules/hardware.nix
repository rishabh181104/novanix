{ config, pkgs, ... }:
{
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 8;
    efi.canTouchEfiVariables = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 8";
  };
# boot.bootspec.extensions = {
#   "org.secureboot.osRelease" = config.environment.etc."os-release".source;
# };
  hardware.enableRedistributableFirmware = true;
}
