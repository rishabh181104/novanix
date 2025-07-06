#!/usr/bin/env bash

# Stylix Integration Script
# Helps integrate Stylix with various applications

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}=== $1 ===${NC}"
}

# Get current theme
CURRENT_THEME=$(grep -o 'theme = "[^"]*"' flake.nix | cut -d'"' -f2)
THEME_DIR="themes/$CURRENT_THEME"

print_header "Stylix Integration Setup"
echo ""

# Check if Stylix is properly configured
if [ ! -f "$THEME_DIR/background.yaml" ]; then
    print_error "Theme $CURRENT_THEME is not properly configured!"
    exit 1
fi

print_status "Current theme: $CURRENT_THEME"
print_status "Theme directory: $THEME_DIR"
echo ""

# Create user config directory if it doesn't exist
USER_CONFIG_DIR="$HOME/.config"
mkdir -p "$USER_CONFIG_DIR"

print_header "Application Integration Guide"
echo ""

print_status "Stylix is now configured with your theme: $CURRENT_THEME"
echo ""

print_status "To integrate with your applications:"
echo ""

echo "1. ${CYAN}Terminals:${NC}"
echo "   - Alacritty: Stylix will automatically configure it"
echo "   - Kitty: Add to kitty.conf:"
echo "     include ~/.cache/stylix/kitty.conf"
echo "   - Foot: Add to foot.ini:"
echo "     include = ~/.cache/stylix/foot.ini"
echo ""

echo "2. ${CYAN}Desktop Environment:${NC}"
echo "   - Waybar: Stylix will automatically configure it"
echo "   - Wlogout: Stylix will automatically configure it"
echo "   - Mako: Stylix will automatically configure it"
echo ""

echo "3. ${CYAN}GTK Applications:${NC}"
echo "   - Stylix will automatically configure GTK theme"
echo "   - Run: gsettings set org.gnome.desktop.interface gtk-theme 'Stylix'"
echo ""

echo "4. ${CYAN}Qt Applications:${NC}"
echo "   - Stylix will automatically configure Qt theme"
echo "   - Use: nwg-look to apply Qt theme"
echo ""

echo "5. ${CYAN}Neovim:${NC}"
echo "   - Install stylix.nvim plugin:"
echo "     use { 'danth/stylix.nvim' }"
echo "   - Add to init.lua:"
echo "     require('stylix').setup()"
echo ""

echo "6. ${CYAN}Cursor/VS Code:${NC}"
echo "   - Install Stylix extension from marketplace"
echo "   - Or use the built-in theme integration"
echo ""

print_header "Manual Configuration Files"
echo ""

# Create a configuration guide
CONFIG_GUIDE="$USER_CONFIG_DIR/stylix-integration-guide.md"

cat > "$CONFIG_GUIDE" << EOF
# Stylix Integration Guide

## Current Theme: $CURRENT_THEME

## Terminal Configuration

### Alacritty
Stylix automatically configures Alacritty. No manual setup needed.

### Kitty
Add to your \`kitty.conf\`:
\`\`\`
include ~/.cache/stylix/kitty.conf
\`\`\`

### Foot
Add to your \`foot.ini\`:
\`\`\`
include = ~/.cache/stylix/foot.ini
\`\`\`

## Desktop Environment

### Waybar
Stylix automatically configures Waybar. No manual setup needed.

### Wlogout
Stylix automatically configures Wlogout. No manual setup needed.

### Mako
Stylix automatically configures Mako. No manual setup needed.

## Applications

### GTK Applications
Stylix automatically configures GTK theme. Run:
\`\`\`
gsettings set org.gnome.desktop.interface gtk-theme 'Stylix'
\`\`\`

### Qt Applications
Stylix automatically configures Qt theme. Use \`nwg-look\` to apply.

### Neovim
Install stylix.nvim plugin and add to your init.lua:
\`\`\`
require('stylix').setup()
\`\`\`

### Cursor/VS Code
Install Stylix extension from marketplace.

## Theme Switching
Use: \`./scripts/theme-switcher.sh <theme-name>\`

Available themes: $(./scripts/list-themes.sh | grep -E "^  [a-z]" | cut -d' ' -f3 | tr '\n' ' ')
EOF

print_status "Configuration guide created: $CONFIG_GUIDE"
echo ""

print_header "Next Steps"
echo ""
print_status "1. Rebuild your system: sudo nixos-rebuild switch --flake .#novanix"
print_status "2. Check the integration guide: cat $CONFIG_GUIDE"
print_status "3. Test theme switching: ./scripts/theme-switcher.sh dracula"
print_status "4. List available themes: ./scripts/list-themes.sh"
echo ""

print_header "Stylix Integration Complete!" 