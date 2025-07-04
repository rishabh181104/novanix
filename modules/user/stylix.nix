{ config, home-manager, lib, pkgs, inputs, userSettings, ... }:

let
themePath = "./../../../themes"+("/"+userSettings.theme+"/"+userSettings.theme)+".yaml";
themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "./../../../themes"+("/"+userSettings.theme)+"/polarity.txt"));
backgroundImage = builtins.readFile (./. + "./../../../themes"+("/"+userSettings.theme)+"/background.png");
in
{

# Manual theme configuration without Stylix to avoid dconf issues
# This will be handled by the system-level Stylix configuration instead

# Set up basic terminal colors manually
  programs.alacritty.settings = {
    colors = {
      primary.background = "#1a1a1a";  # Default dark background
        primary.foreground = "#ffffff";  # Default white text
        cursor.text = "#1a1a1a";
      cursor.cursor = "#ffffff";
      normal.black = "#1a1a1a";
      normal.red = "#ff5555";
      normal.green = "#50fa7b";
      normal.yellow = "#f1fa8c";
      normal.blue = "#bd93f9";
      normal.magenta = "#ff79c6";
      normal.cyan = "#8be9fd";
      normal.white = "#f8f8f2";
      bright.black = "#6272a4";
      bright.red = "#ff6e6e";
      bright.green = "#69ff94";
      bright.yellow = "#ffffa5";
      bright.blue = "#d6acff";
      bright.magenta = "#ff92df";
      bright.cyan = "#a4ffff";
      bright.white = "#ffffff";
    };
    font.size = 18;
    font.normal.family = userSettings.font;
  };

# Enable only non-GNOME targets
  stylix.targets.kitty.enable = true;
  stylix.targets.rofi.enable = if (userSettings.wmType == "wayland") then true else false;

# Wallpaper configuration
# home.file.".config/hypr/hyprpaper.conf".text = ''
#   preload = ${backgroundImage}
# wallpaper = ,${backgroundImage}
# '';

# Blacklist problematic modules that require dconf
  stylix.autoEnable = false;
  stylix.polarity = themePolarity;
  stylix.image = backgroundImage;
  stylix.base16Scheme = ./. + themePath;

# Explicitly disable all GNOME-related targets that require dconf
  stylix.targets.gnome-text-editor.enable = false;
  stylix.targets.gedit.enable = false;
  stylix.targets.gnome.enable = false;
  stylix.targets.gtk.enable = false;

# Override Stylix's module loading to exclude problematic modules
  _module.args.stylixBlacklist = [
    "gnome-text-editor"
      "gedit" 
      "gnome"
  ];

  stylix.fonts = {
    monospace = {
      name = userSettings.font;
      package = userSettings.fontPkg;
    };
    serif = {
      name = userSettings.font;
      package = userSettings.fontPkg;
    };
    sansSerif = {
      name = userSettings.font;
      package = userSettings.fontPkg;
    };
    emoji = {
      name = "Noto Emoji";
      package = pkgs.noto-fonts-monochrome-emoji;
    };
    sizes = {
      terminal = 18;
      applications = 12;
      popups = 12;
      desktop = 12;
    };
  };

  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
    style.name = "breeze-dark";
    platformTheme = "kde";
  };
  fonts.fontconfig.defaultFonts = {
    monospace = [ userSettings.font ];
    sansSerif = [ userSettings.font ];
    serif = [ userSettings.font ];
  };
}

