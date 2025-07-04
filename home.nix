{ config, pkgs, shared, homeDirectory, ... }:

{

  home.username = shared.userName;
  home.homeDirectory = "/home/${shared.userName}";

  xdg.configFile = {
    "hypr" = {
      source = ./dotfiles/hypr;
      recursive = true;
    };
    "alacritty" = {
      source = ./dotfiles/alacritty;
      recursive = true;
    };
    "kitty" = {
      source = ./dotfiles/kitty;
      recursive = true;
    };
    "fish" = {
      source = ./dotfiles/fish;
      recursive = true;
    };
    "fastfetch" = {
      source = ./dotfiles/fastfetch;
      recursive = true;
    };
    "nvim" = {
      source = ./dotfiles/nvim;
      recursive = true;
    };
    "rofi" = {
      source = ./dotfiles/rofi;
      recursive = true;
    };
    "waybar" = {
      source = ./dotfiles/waybar;
      recursive = true;
    };
    "wlogout" = {
      source = ./dotfiles/wlogout;
      recursive = true;
    };
    "qtile" = {
      source = ./dotfiles/qtile;
      recursive = true;
    };
    "picom" = {
      source = ./dotfiles/picom;
      recursive = true;
    };
    "mako" = {
      source = ./dotfiles/mako;
      recursive = true;
    };
  };

# Files for home directory
  home.file = {
#   ".bashrc".source = ./dotfiles/bashrc;
#   ".tmux.conf".source = ./dotfiles/tmux.conf;
    "starship.toml".source = ./dotfiles/starship.toml;
  };

  home.stateVersion = "25.05"; # Please read the comment before changing.

    home.packages = with pkgs; [
    hello
    ];

  home.sessionVariables = {
# EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
