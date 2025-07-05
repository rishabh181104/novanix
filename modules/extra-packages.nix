{ config, pkgs , ... }:

{
  environment.systemPackages = with pkgs ; [
    fish
      starship
      bash
      zsh
      stow
      spotify
      spotify-tray
      openssl
      linuxHeaders
      mkinitcpio-nfs-utils
      linuxKernel.kernels.linux_zen
      stirling-pdf
      thunderbird
      libreoffice-fresh
      ntfs3g
      exfat
      exfatprogs
      gvfs
      mtpfs
      usbutils
      libmtp
      htop
      whatsie
      discord
      grim
      grimblast
      slurp
      ];
}
