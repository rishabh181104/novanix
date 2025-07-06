{ config, pkgs, ... }:

{
  # Centralized package management
  # All system packages are defined here for better organization
  environment.systemPackages = with pkgs; [
    # ===== TERMINAL APPLICATIONS =====
    alacritty
    foot
    kitty
    btop
    htop
    
    # ===== SHELL AND UTILITIES =====
    fish
    starship
    bash
    zsh
    stow
    bat
    bc
    brightnessctl
    ripgrep
    keychain
    wl-clipboard
    xclip
    gnome-keyring
    yafetch
    lazygit
    psmisc
    tree
    
    # ===== EDITORS AND IDEs =====
    code-cursor
    zed-editor
    vim
    neovim
    wget
    fzf
    gnumake
    unzip
    shellcheck
    
    # ===== DEVELOPMENT TOOLS =====
    python3Full
    nodejs_24
    go
    pipx
    python313Packages.pip
    python313Packages.virtualenv
    typescript-language-server
    vscode-langservers-extracted
    pyright
    sqls
    prettier
    lua-language-server
    stylua
    llvmPackages_20.libcxxClang
    astyle
    jdt-language-server
    python313Packages.debugpy
    vimPlugins.vim-ipython
    rPackages.autoimport
    python313Packages.black
    postgresql
    gdb
    shfmt
    cargo
    rustc
    rust-analyzer
    rustfmt
    
    # ===== WAYLAND AND DESKTOP =====
    hyprland
    hypridle
    hyprland-qt-support
    hyprland-qtutils
    hyprlock
    hyprpicker
    pyprland
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
    waybar
    wlogout
    wlroots_0_19
    swww
    rose-pine-hyprcursor
    mako
    pavucontrol
    fuzzel
    
    # ===== QT6 PACKAGES =====
    qt6.qtbase
    qt6.qtsvg
    qt6.qtvirtualkeyboard
    qt6.qtmultimedia
    libsForQt5.xwaylandvideobridge
    xwayland-run
    nwg-look
    
    # ===== GRAPHICS AND THEMING =====
    imagemagick
    flat-remix-gtk
    papirus-icon-theme
    jamesdsp
    
    # ===== BROWSERS =====
    google-chrome
    brave
    
    # ===== MEDIA AND ENTERTAINMENT =====
    spotify
    spotify-tray
    discord
    vlc
    
    # ===== OFFICE AND PRODUCTIVITY =====
    thunderbird
    libreoffice-fresh
    stirling-pdf
    
    # ===== SYSTEM UTILITIES =====
    openssl
    linuxHeaders
    usbutils
    
    # ===== FILE SYSTEM SUPPORT =====
    ntfs3g
    exfat
    exfatprogs
    gvfs
    mtpfs
    libmtp
    
    # ===== SCREENSHOT AND CLIPBOARD =====
    grim
    grimblast
    slurp
    
    # ===== BLUETOOTH =====
    blueman
    bluez
    bluez-tools
    
    # ===== NVIDIA AND VULKAN =====
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    
    # ===== VIRTUAL MACHINES =====
    qemu
    libvirt
    virt-manager
    virt-viewer
    bridge-utils
    spice
    spice-gtk
  ];
} 