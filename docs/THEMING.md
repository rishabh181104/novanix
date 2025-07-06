# Theming Documentation

This document provides comprehensive information about the Novanix theming system, including Stylix integration, available themes, and customization options.

## Table of Contents

- [Overview](#overview)
- [Stylix Integration](#stylix-integration)
- [Available Themes](#available-themes)
- [Theme Management](#theme-management)
- [Customization](#customization)
- [Application Integration](#application-integration)
- [Troubleshooting](#troubleshooting)

## Overview

Novanix features a comprehensive theming system built around Stylix, providing:

- **50+ Pre-configured Themes**: From classic to modern designs
- **Automatic Application Integration**: Themes applied across all supported applications
- **Font Management**: Consistent typography throughout the system
- **Easy Theme Switching**: Simple commands to change themes
- **Custom Theme Support**: Ability to create and add custom themes

## Stylix Integration

### What is Stylix?

Stylix is a NixOS module that provides a unified theming system, automatically applying color schemes, fonts, and wallpapers across your entire system.

### Core Features

- **Base16 Color Schemes**: Standardized color palette format
- **Font Integration**: Consistent typography across applications
- **Wallpaper Management**: Automatic wallpaper application
- **Application Support**: Integration with terminals, editors, browsers, and desktop components

### Configuration Structure

```nix
# modules/stylix.nix
{ config, pkgs, stylix, userSettings, ... }:

{
  stylix = {
    # Wallpaper configuration
    image = ../../wallpapers/your-wallpaper.jpg;
    
    # Color scheme (from themes directory)
    base16Scheme = with stylix.colorSchemes; gruvbox-dark-hard;
    
    # Font configuration
    fonts = {
      serif = with pkgs; { package = noto-fonts; name = "Noto Serif"; };
      sansSerif = with pkgs; { package = noto-fonts; name = "Noto Sans"; };
      monospace = with pkgs; { package = jetbrains-mono; name = "JetBrains Mono"; };
      emoji = with pkgs; { package = noto-fonts-emoji; name = "Noto Color Emoji"; };
    };
  };
}
```

## Available Themes

### Theme Categories

#### Classic Themes
- **Gruvbox Series**: Gruvbox dark/light variants (hard, medium, soft)
- **Solarized**: Solarized dark and light themes
- **Monokai**: Classic Monokai color scheme
- **Dracula**: Popular dark theme with purple accents

#### Modern Themes
- **Catppuccin**: Modern pastel themes (Mocha, Frappe, Latte, Macchiato)
- **Nord**: Arctic-inspired color palette
- **Tokyo Night**: Dark theme inspired by Tokyo
- **One Dark**: Atom editor-inspired theme

#### Specialized Themes
- **Material**: Material Design color schemes
- **Atelier Series**: Professional color schemes (Sulphurpool, Seaside, etc.)
- **Bespin**: Dark theme with warm colors
- **Ember**: Warm, fire-inspired theme

#### Colorful Themes
- **Fairy Floss**: Bright, colorful theme
- **Outrun**: Synthwave-inspired theme
- **Stella**: Vibrant, energetic theme
- **Gigavolt**: Electric blue theme

### Complete Theme List

```
themes/
├── alph/                    # Minimalist theme
├── ashes/                   # Muted, ash-colored theme
├── atelier-cave/            # Dark cave-inspired theme
├── atelier-dune/            # Desert-inspired theme
├── atelier-estuary/         # River-inspired theme
├── atelier-forest/          # Forest-inspired theme
├── atelier-heath/           # Heath-inspired theme
├── atelier-lakeside/        # Lake-inspired theme
├── atelier-plateau/         # Plateau-inspired theme
├── atelier-savanna/         # Savannah-inspired theme
├── atelier-seaside/         # Ocean-inspired theme
├── atelier-sulphurpool/     # Sulfur pool-inspired theme
├── ayu-dark/                # Dark Ayu theme
├── bespin/                  # Bespin cloud city theme
├── catppuccin-frappe/       # Catppuccin Frappe variant
├── catppuccin-mocha/        # Catppuccin Mocha variant
├── darkmoss/                # Dark moss theme
├── doom-one/                # Doom Emacs One theme
├── dracula/                 # Dracula theme
├── ember/                   # Fire-inspired theme
├── emil/                    # Emil theme
├── eris/                    # Eris theme
├── eva/                     # Eva theme
├── everforest/              # Everforest theme
├── fairy-floss/             # Bright, colorful theme
├── gigavolt/                # Electric theme
├── gruvbox-dark-hard/       # Gruvbox dark hard variant
├── gruvbox-dark-medium/     # Gruvbox dark medium variant
├── gruvbox-light-hard/      # Gruvbox light hard variant
├── gruvbox-light-medium/    # Gruvbox light medium variant
├── helios/                  # Sun-inspired theme
├── henna/                   # Henna-inspired theme
├── horizon-dark/            # Dark horizon theme
├── io/                      # Io theme
├── isotope/                 # Isotope theme
├── manegarm/                # Manegarm theme
├── material-vivid/          # Material Design vivid theme
├── miramare/                # Miramare theme
├── monokai/                 # Classic Monokai theme
├── nord/                    # Nord theme
├── oceanic-next/            # Oceanic Next theme
├── old-hope/                # Old Hope theme
├── outrun-dark/             # Synthwave-inspired theme
├── selenized-dark/          # Selenized dark theme
├── selenized-light/         # Selenized light theme
├── solarized-dark/          # Solarized dark theme
├── solarized-light/         # Solarized light theme
├── spaceduck/               # Space-themed theme
├── stella/                  # Stella theme
├── summerfruit-dark/        # Summer fruit dark theme
├── tomorrow-night/          # Tomorrow Night theme
├── twilight/                # Twilight theme
├── ubuntu/                  # Ubuntu-inspired theme
├── uwunicorn/               # Unicorn theme
├── windows-95/              # Windows 95-inspired theme
├── woodland/                # Woodland theme
└── xcode-dusk/              # Xcode Dusk theme
```

## Theme Management

### Listing Themes

```bash
# List all available themes
./scripts/list-themes.sh

# List themes with descriptions
ls themes/ | while read theme; do
  echo "Theme: $theme"
  if [ -f "themes/$theme/description.txt" ]; then
    cat "themes/$theme/description.txt"
  fi
  echo "---"
done
```

### Switching Themes

#### Using the Script
```bash
# Switch to a specific theme
./scripts/switch-theme.sh catppuccin-mocha

# Switch with confirmation
./scripts/switch-theme.sh gruvbox-dark-hard --confirm
```

#### Manual Theme Switching
1. **Edit flake.nix**:
```nix
userSettings = {
  # ... other settings
  theme = "catppuccin-mocha";  # Change this line
};
```

2. **Rebuild the system**:
```bash
sudo nixos-rebuild switch --flake .#novanix
```

### Theme Preview

To preview themes before applying:

```bash
# Generate theme previews
./scripts/preview-themes.sh

# View specific theme
./scripts/preview-theme.sh gruvbox-dark-hard
```

## Customization

### Creating Custom Themes

#### 1. Create Theme Directory
```bash
mkdir themes/my-custom-theme
cd themes/my-custom-theme
```

#### 2. Create Theme Files
```nix
# themes/my-custom-theme/default.nix
{ pkgs, ... }:

{
  slug = "my-custom-theme";
  name = "My Custom Theme";
  author = "Your Name";
  colors = {
    base00 = "#1a1a1a";  # Background
    base01 = "#2a2a2a";  # Lighter background
    base02 = "#3a3a3a";  # Selection background
    base03 = "#4a4a4a";  # Comments, invisibles
    base04 = "#5a5a5a";  # Dark foreground
    base05 = "#6a6a6a";  # Default foreground
    base06 = "#7a7a7a";  # Light foreground
    base07 = "#8a8a8a";  # Light background
    base08 = "#ff5555";  # Variables
    base09 = "#ffb86c";  # Integers
    base0A = "#f1fa8c";  # Classes
    base0B = "#50fa7b";  # Strings
    base0C = "#8be9fd";  # Support
    base0D = "#bd93f9";  # Functions
    base0E = "#ff79c6";  # Keywords
    base0F = "#ff5555";  # Deprecated
  };
}
```

#### 3. Add Theme Description
```bash
# themes/my-custom-theme/description.txt
A custom theme with dark background and vibrant accents.
Perfect for long coding sessions with excellent contrast.
```

#### 4. Update Theme List
```bash
# Add to theme listing script
echo "my-custom-theme" >> scripts/theme-list.txt
```

### Customizing Fonts

#### Font Configuration
```nix
# modules/stylix.nix
stylix.fonts = {
  serif = with pkgs; { 
    package = noto-fonts; 
    name = "Noto Serif"; 
  };
  sansSerif = with pkgs; { 
    package = inter; 
    name = "Inter"; 
  };
  monospace = with pkgs; { 
    package = jetbrains-mono; 
    name = "JetBrains Mono"; 
  };
  emoji = with pkgs; { 
    package = noto-fonts-emoji; 
    name = "Noto Color Emoji"; 
  };
};
```

#### Available Fonts
- **Serif**: Noto Serif, Source Serif Pro, Merriweather
- **Sans Serif**: Inter, Noto Sans, Source Sans Pro, Open Sans
- **Monospace**: JetBrains Mono, Fira Code, Source Code Pro, Hack
- **Emoji**: Noto Color Emoji, Twitter Color Emoji

### Customizing Wallpapers

#### Wallpaper Configuration
```nix
# modules/stylix.nix
stylix.image = ../../wallpapers/your-wallpaper.jpg;
```

#### Wallpaper Management
```bash
# Create wallpapers directory
mkdir wallpapers

# Add your wallpapers
cp ~/Pictures/wallpaper.jpg wallpapers/

# Update configuration
# Edit modules/stylix.nix to point to your wallpaper
```

## Application Integration

### Supported Applications

#### Terminals
- **Alacritty**: GPU-accelerated terminal
- **Kitty**: Feature-rich terminal
- **Foot**: Wayland-native terminal

#### Desktop Components
- **Waybar**: Status bar
- **Wlogout**: Logout menu
- **Mako**: Notifications
- **Hyprland**: Window manager

#### Editors
- **Neovim**: Vim-based editor
- **Cursor**: VS Code-based editor
- **Helix**: Modern editor

#### Browsers
- **Brave**: Privacy-focused browser
- **Chrome**: Feature-rich browser

#### System Components
- **GTK Applications**: File managers, settings
- **QT Applications**: KDE applications
- **System Dialogs**: Login, file picker

### Integration Configuration

#### Terminal Integration
```nix
# Automatic terminal configuration
programs.alacritty.settings = {
  colors = with config.stylix.colors; {
    primary = {
      background = base00;
      foreground = base05;
    };
    cursor = {
      text = base00;
      cursor = base05;
    };
    normal = {
      black = base00;
      red = base08;
      green = base0B;
      yellow = base0A;
      blue = base0D;
      magenta = base0E;
      cyan = base0C;
      white = base05;
    };
  };
};
```

#### GTK Integration
```nix
# GTK theme configuration
gtk = {
  enable = true;
  theme = {
    name = "Adwaita-dark";
    package = pkgs.gnome.gnome-themes-extra;
  };
  iconTheme = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
  };
};
```

## Troubleshooting

### Common Issues

#### Theme Not Applying
```bash
# Regenerate theme cache
stylix generate

# Check theme files
ls -la ~/.config/stylix/

# Verify theme configuration
nixos-option stylix.base16Scheme
```

#### Font Issues
```bash
# Update font cache
fc-cache -f -v

# Check font availability
fc-list | grep "Font Name"

# Verify font configuration
nixos-option stylix.fonts
```

#### Application Not Themed
```bash
# Check application support
./scripts/stylix-integration.sh

# Manual application configuration
# Follow the integration guide for specific applications
```

### Debugging Commands

#### Theme Debugging
```bash
# Check current theme
echo $STYLIX_THEME

# View theme colors
cat ~/.config/stylix/colors.json

# Check theme generation
stylix generate --verbose
```

#### Font Debugging
```bash
# List installed fonts
fc-list

# Check font rendering
fc-match "Font Name"

# Test font display
echo "Test text" | pango-view --font="Font Name" -
```

### Recovery Procedures

#### Reset to Default Theme
```bash
# Switch to default theme
./scripts/switch-theme.sh gruvbox-dark-hard

# Rebuild system
sudo nixos-rebuild switch --flake .#novanix
```

#### Reset Font Configuration
```nix
# Reset to default fonts in modules/stylix.nix
stylix.fonts = {
  serif = with pkgs; { package = noto-fonts; name = "Noto Serif"; };
  sansSerif = with pkgs; { package = noto-fonts; name = "Noto Sans"; };
  monospace = with pkgs; { package = jetbrains-mono; name = "JetBrains Mono"; };
  emoji = with pkgs; { package = noto-fonts-emoji; name = "Noto Color Emoji"; };
};
```

## Advanced Configuration

### Theme Variants

#### Light/Dark Variants
```nix
# Dynamic theme switching based on time
stylix.base16Scheme = 
  if (builtins.readFile "/sys/class/backlight/intel_backlight/brightness" > "100") 
  then stylix.colorSchemes.gruvbox-light-hard 
  else stylix.colorSchemes.gruvbox-dark-hard;
```

#### Seasonal Themes
```bash
# Create seasonal theme script
cat > scripts/seasonal-theme.sh << 'EOF'
#!/bin/bash
month=$(date +%m)
case $month in
  12|01|02) theme="nord" ;;      # Winter
  03|04|05) theme="everforest" ;; # Spring
  06|07|08) theme="summerfruit-dark" ;; # Summer
  09|10|11) theme="woodland" ;;   # Autumn
esac
./scripts/switch-theme.sh $theme
EOF
chmod +x scripts/seasonal-theme.sh
```

### Performance Optimization

#### Theme Caching
```nix
# Enable theme caching
stylix.cursor.package = pkgs.rose-pine-cursor;
stylix.cursor.name = "rose-pine-cursor";
```

#### Font Optimization
```nix
# Optimize font rendering
fonts.fontconfig = {
  enable = true;
  antialias = true;
  hinting = {
    enable = true;
    style = "slight";
  };
  subpixel = {
    rgba = "rgb";
    lcdfilter = "default";
  };
};
```

This documentation provides a comprehensive guide to the Novanix theming system, enabling users to fully customize their desktop experience with beautiful, consistent themes across all applications. 