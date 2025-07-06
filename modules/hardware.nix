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
  # Custom hardware settings go here. This is NOT the generated hardware.nix.
  # Example: enable redistributable firmware
  hardware.enableRedistributableFirmware = true;
}
