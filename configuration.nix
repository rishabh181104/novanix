{ config, pkgs, lib, systemSettings, userSettings, ... }:
{
  imports =
    [
    ./hardware.nix
      ./modules/browser/brave.nix
      ./modules/browser/google-chrome.nix
      ./modules/system/dbus.nix
      ./modules/system/time.nix
      ./modules/system/fonts.nix
      ./modules/system/opengl.nix
      ./modules/system/stylix.nix
      ./modules/system/wayland.nix
      ./modules/system/bluetooth.nix
      ./modules/user/stylix.nix
      ./modules/user/git.nix
      ./modules/user/power.nix
      ./modules/user/steam.nix
      ./modules/user/network.nix
      ./modules/user/hyprland.nix
    ];


# For nix path
  nix.nixPath = [ "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=$HOME/dotfiles/system/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

# To endure flakes are enabled
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    '';

# For google-chrome brave and many more
  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;
  services.udev.packages = with pkgs; [ libmtp ];


# Use systemd-boot if uefi, default to grub otherwise
  boot.loader.systemd-boot.enable = if (systemSettings.bootMode == "uefi") then true else false;
  boot.loader.efi.canTouchEfiVariables = if (systemSettings.bootMode == "uefi") then true else false;
  boot.loader.efi.efiSysMountPoint = systemSettings.bootMountPath;
  boot.loader.grub.enable = if (systemSettings.bootMode == "uefi") then false else true;
  boot.loader.grub.device = systemSettings.grubDevice;

# Garbage Collecting
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 8";
  };

# Kernel Modules
  boot.kernelModules = lib.mkForce [ "kvm-intel" "iwlwifi" "i2c-dev" "i2c-piix4" "cpufreq_powersave" ];
  boot.initrd.availableKernelModules = lib.mkForce [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];

# Networking
  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;

# Timezone and locale
  time.timeZone = systemSettings.timezone; # time zone
    i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

# User account
  users.users.${userSettings.username} = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "libvirtd" "kvm" "wheel" "input" "dialout" "video" "render" ];
    packages = with pkgs; [
      fish
    ];
    uid = 1000;
  };

# System Shell configuration
  environment.shells = with pkgs; [ bash zsh fish ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

# Enable KVM and libvirtd
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
      };
    };
  };

# For Automounting usb's etc.
  services.udisks2.enable = true;
  services.udev.extraRules = ''
# Example: Mount USB drives to /media/<label> automatically
    ACTION=="add", SUBSYSTEM=="block", ENV{ID_FS_USAGE}=="filesystem", RUN+="${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect $devnode /media/%E{ID_FS_LABEL}"
    '';
  security.polkit.enable = true;

# XDG Portals
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
    ];
  };

# Explicitly enable or disable open-source kernel modules
  hardware.nvidia = {
# open = true; # Use open-source kernel modules (recommended for RTX/GTX 16xx GPUs)
    open = false; # Use proprietary kernel modules (uncomment if needed for older GPUs)
  };

# Picom
  services.picom.enable = true;

# Enable touchpad support
  services.libinput.enable = true;

# Enable the OpenSSH daemon.
  services.openssh.enable = true;

# Pipewire for audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

# System Packages
  environment.systemPackages = with pkgs; [
    vim
      logseq
      wget
      zsh
      git
      cryptsetup
      home-manager
      wpa_supplicant
      dbus
      dconf
  ];

# Leave it unchaged plz
  system.stateVersion = "25.05";

}
