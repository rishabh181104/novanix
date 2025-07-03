{ config, pkgs, userSettings, ... }:

{
# Home Manager needs a bit of information about you and the paths it should
# manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  programs.home-manager.enable = true;

  home.stateVersion = "25.05";

  home.packages = (with pkgs; [
# Killall 
      killall
# Terminals
      alacritty kitty foot
# some tools for daily use
      bat bc brightnessctl ripgrep keychain wl-clipboard xclip gnome-keyring psmisc mupdf
# Shells
      fish zsh bash starship
# Tools for files in another format
      ntfs3g exfat exfatprogs gvfs mtpfs usbutils libmtp
# For system information
      htop btop
# For Browser
      brave google-chrome
# Code Editors
      code-cursor zed-editor vim neovim
# git
      git lazygit
# File Manager
      nautilus xfce.thunar
# Nvidia 
      vulkan-loader vulkan-tools
# blueman
      blueman bluez bluez-tools
# fetch
      fastfetch
# network
      networkmanager networkmanagerapplet
# screenshot
      grim grimblast slurp
# XDG
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
# bar
      waybar
# themes 
      flat-remix-gtk papirus-icon-theme
# audio
      pavucontrol jamesdsp
# for video and images
      imagemagick vlc
# For my neovim installation and my development env
      fzf
      shellcheck
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

# Packages for Hyprland
      hyprland
      hypridle
      hyprland-qt-support
      hyprland-qtutils
      hyprlock
      hyprpicker
      pyprland
      wlogout
      wlroots_0_19
      swww
      rose-pine-hyprcursor
      libsForQt5.xwaylandvideobridge
      xwayland-run
      mako
      nwg-look
      rofi-wayland

# i like to use sometimes
      stirling-pdf thunderbird libreoffice-fresh whatsie discord unzip gnumake
      ])

}
