{
  description = "My NixOS Flake";

  outputs = { self, nixpkgs, stylix, ... }@inputs: {
    let {
# ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        system = "x86_64-linux";
        hostname = "novanix";
        timezone = "Asia/Kolkata";
        locale = "en_IN/UTF-8";
        bootMode = "uefi";
        bootMountPath = "/boot";
        grubDevice = "";
        gpuType = "nvidia";
      };

# ----- USER SETTINGS ----- #
      userSettings = rec {
        username = "nova";
        name = "rishabh181104";
        email = "rishabhhaldiya18@gmail.com";
        dotfilesDir = "~/novanix";
        theme = "io";
        wm = "hyprland";
        wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
        browser = "brave";
        term = "alacritty";
        editor = "neovide";
      }
    };
    in {
      nixosConfigurations = {
        systemSettings.hostname = nixpkgs.lib.nixosSystem {
          systemSettings.system;
          modules = [
            ./configuration.nix
# ({ pkgs, ... }: {
#  nix.settings.experimental-features = [ "nix-command" "flakes" ];
#  environment.systemPackages = with pkgs; [
#  wget curl git htop neovim tmux
#  firefox vscode libreoffice
#  mpv feh pavucontrol
#  ];
#  })
              stylix.nixosModules.stylix
# ({ pkgs, ... }: {
#  stylix = {
#  image = ./wallpaper.jpg; # Replace with your wallpaper
#  base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
#  fonts = {
#  serif = {
#  package = pkgs.dejavu_fonts;
#  name = "DejaVu Serif";
#  };
#  sansSerif = {
#  package = pkgs.dejavu_fonts;
#  name = "DejaVu Sans";
#  };
#  monospace = {
#  package = pkgs.jetbrains-mono;
#  name = "JetBrains Mono";
#  };
#  };
#  };
#  })
              ];
        };
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
