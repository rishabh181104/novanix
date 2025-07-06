{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Shell and terminal utilities
    fish
    starship
    bash
    zsh
    stow
    htop
    btop
    
    # Media and entertainment
    spotify
    spotify-tray
    discord
    vlc
    
    # Office and productivity
    thunderbird
    libreoffice-fresh
    stirling-pdf
    
    # System utilities
    openssl
    linuxHeaders
    usbutils
    
    # File system support
    ntfs3g
    exfat
    exfatprogs
    gvfs
    mtpfs
    libmtp
    
    # Screenshot and clipboard tools
    grim
    grimblast
    slurp
    wl-clipboard
    xclip
    
    # Development tools (some may be duplicates from dev.nix)
    git
    lazygit
    ripgrep
    bat
    fzf
  ];
}
