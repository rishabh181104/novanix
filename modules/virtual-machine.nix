{ config, pkgs, ... }:
{
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
  environment.systemPackages = with pkgs; [
    qemu
      libvirt
      virt-manager
      virt-viewer
      bridge-utils
      spice
      spice-gtk
  ];
}

