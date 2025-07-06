#!/usr/bin/env bash

# Theme Lister for NixOS with Stylix
# Lists all available themes with their polarity

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_header() {
    echo -e "${BLUE}=== Available Themes ===${NC}"
}

print_theme() {
    local theme_name="$1"
    local polarity="$2"
    local current_theme="$3"
    
    if [ "$theme_name" = "$current_theme" ]; then
        echo -e "${GREEN}✓ ${theme_name}${NC} (${polarity}) ${YELLOW}[CURRENT]${NC}"
    else
        echo -e "  ${theme_name} (${polarity})"
    fi
}

print_info() {
    echo -e "${CYAN}[INFO]${NC} $1"
}

# Get current theme from flake.nix
CURRENT_THEME=$(grep -o 'theme = "[^"]*"' flake.nix | cut -d'"' -f2)

print_header
echo ""

# Check if themes directory exists
if [ ! -d "themes" ]; then
    echo -e "${RED}Error: themes directory not found!${NC}"
    exit 1
fi

# List all themes
for theme_dir in themes/*/; do
    if [ -d "$theme_dir" ]; then
        theme_name=$(basename "$theme_dir")
        
        # Check if theme has required files
        if [ -f "$theme_dir/background.png" ] && [ -f "$theme_dir/background.yaml" ]; then
            # Get polarity if available
            if [ -f "$theme_dir/polarity.txt" ]; then
                polarity=$(cat "$theme_dir/polarity.txt" | tr '[:upper:]' '[:lower:]')
            else
                polarity="unknown"
            fi
            
            print_theme "$theme_name" "$polarity" "$CURRENT_THEME"
        else
            echo -e "${RED}⚠  ${theme_name}${NC} (incomplete - missing required files)"
        fi
    fi
done

echo ""
print_info "Current theme: ${YELLOW}${CURRENT_THEME}${NC}"
echo ""
print_info "To switch themes, use: ${CYAN}./scripts/theme-switcher.sh <theme-name>${NC}"
print_info "Example: ${CYAN}./scripts/theme-switcher.sh dracula${NC}" 