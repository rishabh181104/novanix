{ config, pkgs, userSettings, systemSettings, ... }:

{
  # Global settings
  nixpkgs.config.allowUnfree = true;
  security.sudo.wheelNeedsPassword = true;
  security.audit.enable = true;
  # Optionally, enable AppArmor for extra security:
  # security.apparmor.enable = true; 

  imports = [
    ./hardware.nix
    ./modules/stylix.nix
    ./modules/network.nix
    ./modules/dm.nix
    ./modules/dev.nix
    ./modules/user.nix
    ./modules/xorg.nix
    ./modules/fonts.nix
    ./modules/power.nix
    ./modules/nvidia.nix
    ./modules/services.nix
    ./modules/hardware.nix
    ./modules/firewall.nix
    ./modules/browser.nix
    ./modules/editors.nix
    ./modules/wayland.nix
    ./modules/terminal.nix
    ./modules/virtual-machine.nix
    ./modules/extra-packages.nix
    ./modules/bluetooth.nix
  ];

  system.stateVersion = "25.05"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
