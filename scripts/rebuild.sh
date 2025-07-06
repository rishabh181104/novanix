#!/usr/bin/env bash

# NixOS Rebuild Script
# This script helps rebuild the NixOS configuration with proper error handling

set -e

echo "🔄 Starting NixOS configuration rebuild..."

# Check if we're running as root
if [[ $EUID -eq 0 ]]; then
  echo "❌ This script should not be run as root"
  exit 1
fi

# Check if we're in the correct directory
if [[ ! -f "flake.nix" ]]; then
  echo "❌ Please run this script from the directory containing flake.nix"
  exit 1
fi

echo "📋 Building configuration..."
echo "   This may take a few minutes..."

# Build the configuration
if sudo nixos-rebuild build --flake .#novanix; then
  echo "✅ Configuration built successfully!"

  echo "🔍 Checking for potential issues..."

  # Check if Stylix theme files exist
  if [[ -f "themes/gruvbox-dark-hard/background.png" && -f "themes/gruvbox-dark-hard/background.yaml" ]]; then
    echo "✅ Stylix theme files found"
  else
    echo "⚠️  Warning: Stylix theme files not found"
  fi

  echo ""
  echo "🚀 Configuration is ready to apply!"
  echo "   Run: sudo nixos-rebuild switch --flake .#novanix"
  echo ""
  echo "💡 Or to test without applying:"
  echo "   Run: sudo nixos-rebuild test --flake .#novanix"

else
  echo "❌ Configuration build failed!"
  echo "   Please check the error messages above"
  exit 1
fi

