#!/usr/bin/env bash

# Theme Switcher for NixOS with Stylix
# Usage: ./theme-switcher.sh <theme-name>

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
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

# Check if theme name is provided
if [ $# -eq 0 ]; then
    print_error "No theme specified!"
    echo "Usage: $0 <theme-name>"
    echo ""
    print_header "Available themes:"
    ls -1 themes/ | grep -v "^$"
    exit 1
fi

THEME_NAME="$1"
THEME_DIR="themes/$THEME_NAME"

# Check if theme exists
if [ ! -d "$THEME_DIR" ]; then
    print_error "Theme '$THEME_NAME' not found!"
    echo "Available themes:"
    ls -1 themes/ | grep -v "^$"
    exit 1
fi

# Check if theme has required files
if [ ! -f "$THEME_DIR/background.png" ] || [ ! -f "$THEME_DIR/background.yaml" ]; then
    print_error "Theme '$THEME_NAME' is missing required files (background.png or background.yaml)"
    exit 1
fi

print_header "Switching to theme: $THEME_NAME"

# Backup current flake.nix
print_status "Backing up current flake.nix..."
cp flake.nix flake.nix.backup

# Update the theme in flake.nix
print_status "Updating theme in flake.nix..."
sed -i "s/theme = \".*\";/theme = \"$THEME_NAME\";/" flake.nix

# Verify the change
if grep -q "theme = \"$THEME_NAME\";" flake.nix; then
    print_status "Theme updated successfully in flake.nix"
else
    print_error "Failed to update theme in flake.nix"
    cp flake.nix.backup flake.nix
    exit 1
fi

# Rebuild the system
print_status "Rebuilding system with new theme..."
print_warning "This will take a few minutes..."

if sudo nixos-rebuild switch --flake .#novanix; then
    print_status "System rebuilt successfully!"
    print_status "Theme '$THEME_NAME' is now active"
    
    # Show theme info
    if [ -f "$THEME_DIR/polarity.txt" ]; then
        POLARITY=$(cat "$THEME_DIR/polarity.txt")
        print_status "Theme polarity: $POLARITY"
    fi
    
    # Clean up backup
    rm flake.nix.backup
else
    print_error "System rebuild failed!"
    print_status "Restoring previous configuration..."
    cp flake.nix.backup flake.nix
    exit 1
fi

print_header "Theme switch complete!" 