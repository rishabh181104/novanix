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
    ./modules/packages.nix
    (import ./modules/stylix.nix { inherit userSettings systemSettings; })
    (import ./modules/network.nix { inherit userSettings systemSettings; })
    ./modules/dm.nix
    ./modules/dev.nix
    (import ./modules/user.nix { inherit userSettings systemSettings; })
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
    (import ./modules/git.nix { inherit userSettings; })
  ];

  system.stateVersion = "25.05"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
