{
  description = "Flake for Nova";

<<<<<<< HEAD
  outputs = inputs@{ self, pkgs, ... }:
    let
# ---- SYSTEM SETTINGS ---- #
=======
  outputs = inputs@{ self , ... };
  let 

## ----- System Settings ---- ##
>>>>>>> bb832e4 (s)
    systemSettings = {
      system = "x86_64-linux";
      hostname = "nova";
      timezone = "Asia/Kolkata";
      locale = "en_IN.UTF-8";
      bootMode = "uefi";
      bootMountPath = "/boot";
      gpuType = "nvidia";
    };

## ---- User Settings ---- ##
  userSettings = rec {
<<<<<<< HEAD
    username = "ste"; # username
      name = "Rishabh"; # name/identifier
      email = "rishabhhaldiya18@gmail.com"; # email (used for certain configurations)
      dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
      theme = "io"; # selcted theme from my themes directory (./themes/)
      wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
# window manager type (hyprland or x11) translator
      wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
    browser = "qutebrowser"; # Default browser; must select one from ./user/app/browser/
      spawnBrowser = if ((browser == "qutebrowser") && (wm == "hyprland")) then "qutebrowser-hyprprofile" else (if (browser == "qutebrowser") then "qutebrowser --qt-flag enable-gpu-rasterization --qt-flag enable-native-gpu-memory-buffers --qt-flag num-raster-threads=4" else browser); # Browser spawn command must be specail for qb, since it doesn't gpu accelerate by default (why?)
      defaultRoamDir = "Personal.p"; # Default org roam directory relative to ~/Org
      term = "alacritty"; # Default terminal command;
    font = "MesloLGS Nerd Font"; # Selected font
      editor = "zeditor"; # Default editor;
# editor spawning translator
# generates a command that can be used to spawn editor inside a gui
# EDITOR and TERM session variables must be set in home.nix or other module
# I set the session variable SPAWNEDITOR to this in my home.nix for convenience
    spawnEditor = if (editor == "emacsclient") then
      "emacsclient -c -a 'emacs'"
      else
        (if ((editor == "vim") ||
             (editor == "nvim") ||
             (editor == "nano")) then
         "exec " + term + " -e " + editor
         else
         (if (editor == "neovide") then
          "neovide -- --listen /tmp/nvimsocket"
          else
          editor));
=======
    username = "ste";
    name = "Rishabh";
    email = "rishabhhaldiya18@gmail.com";
    dotfilesDir = "~/novanix";
    theme = "io";
    wm = "hyprland";
    wmType = if (( wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
    browser = "brave";
    term = "alacritty";
    font = "MesloLGS Nerd Font Mono";
    fontPkg = pkgs.meslo-lgs-nf;
    editor = "zeditor";
>>>>>>> bb832e4 (s)
  };

  in {
    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };

    nixosConfigurations = {
      system = lib.nixosSystem {
        system = systemSettings.system;
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
