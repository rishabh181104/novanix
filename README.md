# Novanix - NixOS Configuration

A comprehensive, modular NixOS configuration with centralized package management, Stylix theming, and extensive customization options.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [System Requirements](#system-requirements)
- [Installation](#installation)
- [Configuration Structure](#configuration-structure)
- [Package Management](#package-management)
- [Theming System](#theming-system)
- [Module Documentation](#module-documentation)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

## 🎯 Overview

Novanix is a modern NixOS configuration designed for developers and power users. It features:

- **Modular Architecture**: Clean separation of concerns with dedicated modules
- **Centralized Package Management**: All packages managed in one location
- **Stylix Integration**: Comprehensive theming system with 50+ themes
- **Hyprland Desktop**: Modern Wayland-based desktop environment
- **Development Ready**: Full development toolchain and language support
- **Virtualization Support**: QEMU/KVM with virt-manager integration

## ✨ Features

### 🖥️ Desktop Environment
- **Hyprland**: Modern Wayland compositor with tiling capabilities
- **Waybar**: Customizable status bar
- **Wlogout**: Secure logout menu
- **Mako**: Desktop notifications
- **SWWW**: Dynamic wallpaper support

### 🎨 Theming
- **Stylix Integration**: Automatic theme application across applications
- **50+ Pre-configured Themes**: From classic to modern designs
- **Font Management**: Consistent typography across the system
- **Icon Themes**: Papirus and Flat Remix icon sets

### 🛠️ Development Tools
- **Multiple Languages**: Python, Node.js, Go, Rust, Lua support
- **Language Servers**: TypeScript, Python, Lua, Java, SQL
- **Code Formatting**: Black, Prettier, Stylua, Rustfmt
- **Debugging**: GDB, debugpy integration
- **Version Control**: Git with lazygit interface

### 🎵 Media & Entertainment
- **Spotify**: Music streaming with tray integration
- **Discord**: Communication platform
- **VLC**: Media player
- **Thunderbird**: Email client
- **LibreOffice**: Office suite

### 🔧 System Utilities
- **Fish Shell**: Modern shell with starship prompt
- **Multiple Terminals**: Alacritty, Foot, Kitty
- **File Management**: Advanced file system support
- **Screenshot Tools**: Grim, Grimblast with area selection
- **Clipboard Management**: wl-clipboard, xclip

## 💻 System Requirements

### Minimum Requirements
- **Architecture**: x86_64-linux
- **RAM**: 8GB (16GB recommended)
- **Storage**: 50GB available space
- **Graphics**: NVIDIA GPU (GTX 1060 or better recommended)

### Recommended Requirements
- **RAM**: 16GB or more
- **Storage**: 100GB+ SSD
- **Graphics**: NVIDIA RTX series for optimal performance
- **Network**: Stable internet connection for package downloads

## 🚀 Installation

### Prerequisites
1. **NixOS**: Ensure you have NixOS installed
2. **Git**: Clone this repository
3. **NVIDIA Drivers**: Compatible NVIDIA GPU and drivers

### Quick Start
```bash
# Clone the repository
git clone https://github.com/yourusername/novanix.git
cd novanix

# Build and switch to the configuration
sudo nixos-rebuild switch --flake .#novanix
```

### First-Time Setup
1. **Update System Settings**: Modify `flake.nix` to match your system
2. **Configure User**: Update `userSettings` in `flake.nix`
3. **Hardware Configuration**: Ensure `hardware.nix` matches your system
4. **Rebuild**: Run the rebuild command above

## 📁 Configuration Structure

```
novanix/
├── flake.nix                 # Main flake configuration
├── configuration.nix         # Primary system configuration
├── hardware.nix             # Hardware-specific settings
├── modules/                 # Modular configuration files
│   ├── packages.nix         # Centralized package management
│   ├── stylix.nix          # Theming configuration
│   ├── wayland.nix         # Wayland/Hyprland setup
│   ├── network.nix         # Network configuration
│   ├── nvidia.nix          # NVIDIA driver settings
│   ├── dev.nix             # Development tools
│   ├── terminal.nix        # Terminal applications
│   ├── editors.nix         # Text editors and IDEs
│   ├── browser.nix         # Web browsers
│   ├── bluetooth.nix       # Bluetooth configuration
│   ├── virtual-machine.nix # Virtualization setup
│   ├── services.nix        # System services
│   ├── power.nix           # Power management
│   ├── firewall.nix        # Firewall rules
│   ├── fonts.nix           # Font configuration
│   ├── dm.nix              # Display manager
│   ├── xorg.nix            # X11 configuration
│   ├── user.nix            # User settings
│   └── extra-packages.nix  # Additional packages
├── themes/                 # Stylix theme collection
│   ├── gruvbox-dark-hard/
│   ├── catppuccin-mocha/
│   ├── nord/
│   └── ... (50+ themes)
└── scripts/                # Management scripts
    ├── manage-packages.sh  # Package management
    ├── list-themes.sh      # Theme listing
    └── stylix-integration.sh # Theme integration guide
```

## 📦 Package Management

### Centralized Package System
All packages are managed in `modules/packages.nix` and organized by category:

- **Terminal Applications**: Terminal emulators and CLI tools
- **Shell and Utilities**: Shell environments and system utilities
- **Editors and IDEs**: Text editors and development environments
- **Development Tools**: Programming languages and development utilities
- **Wayland and Desktop**: Desktop environment components
- **Browsers**: Web browsers
- **Media and Entertainment**: Media players and entertainment apps
- **Office and Productivity**: Office suites and productivity tools
- **System Utilities**: System administration tools
- **File System Support**: File system drivers and utilities
- **Bluetooth**: Bluetooth management tools
- **NVIDIA and Vulkan**: Graphics drivers and Vulkan support
- **Virtual Machines**: Virtualization tools

### Package Management Script
Use the included script for easy package management:

```bash
# List all packages by category
./scripts/manage-packages.sh list

# Search for a specific package
./scripts/manage-packages.sh search firefox

# Add a new package
./scripts/manage-packages.sh add firefox BROWSERS

# Remove a package
./scripts/manage-packages.sh remove spotify

# Rebuild system after changes
./scripts/manage-packages.sh rebuild
```

## 🎨 Theming System

### Stylix Integration
The configuration includes comprehensive Stylix theming with:

- **Automatic Theme Application**: Themes applied across all supported applications
- **Font Integration**: Consistent typography with custom fonts
- **Application Support**: Integration with terminals, editors, browsers, and desktop components

### Available Themes
50+ pre-configured themes including:

- **Classic Themes**: Gruvbox, Solarized, Monokai
- **Modern Themes**: Catppuccin, Nord, Dracula
- **Specialized Themes**: Material, Atelier series, Bespin
- **Colorful Themes**: Fairy Floss, Outrun, Stella

### Theme Management
```bash
# List available themes
./scripts/list-themes.sh

# Switch themes
./scripts/switch-theme.sh <theme-name>

# Generate integration guide
./scripts/stylix-integration.sh
```

### Theme Integration
The configuration automatically applies themes to:

- **Terminals**: Alacritty, Kitty, Foot
- **Desktop Components**: Waybar, Wlogout, Mako
- **Editors**: Neovim, Cursor, Helix
- **Browsers**: Brave, Chrome
- **System Components**: GTK, QT applications

## 📚 Module Documentation

### Core Modules

#### `packages.nix`
**Purpose**: Centralized package management
**Key Features**:
- All system packages in one location
- Organized by functional categories
- Easy to maintain and update

#### `stylix.nix`
**Purpose**: Comprehensive theming configuration
**Key Features**:
- Stylix integration with 50+ themes
- Font configuration and application integration
- Automatic theme application across applications

#### `wayland.nix`
**Purpose**: Wayland and Hyprland configuration
**Key Features**:
- Hyprland compositor setup
- XDG portal configuration
- QT6 and GTK integration

#### `nvidia.nix`
**Purpose**: NVIDIA graphics configuration
**Key Features**:
- Proprietary driver setup
- Power management
- Vulkan support
- PRIME offload support

#### `dev.nix`
**Purpose**: Development environment setup
**Key Features**:
- Multiple programming language support
- Language servers and debugging tools
- Code formatting and linting tools

### System Modules

#### `network.nix`
**Purpose**: Network configuration
**Features**: NetworkManager, DHCP, firewall rules

#### `services.nix`
**Purpose**: System services
**Features**: SSH, printing, audio, systemd services

#### `user.nix`
**Purpose**: User account configuration
**Features**: User creation, shell setup, group membership

#### `virtual-machine.nix`
**Purpose**: Virtualization support
**Features**: QEMU/KVM, virt-manager, SPICE support

## 🔧 Customization

### System Settings
Modify `flake.nix` to customize system settings:

```nix
systemSettings = {
  system = "x86_64-linux";
  hostname = "your-hostname";
  timezone = "Your/Timezone";
  locale = "en_US.UTF-8";
  bootMode = "uefi";
  bootMountPath = "/boot";
  gpuType = "nvidia";
};
```

### User Settings
Customize user configuration in `flake.nix`:

```nix
userSettings = {
  username = "your-username";
  name = "Your Name";
  email = "your.email@example.com";
  dotfilesDir = "~/novanix";
  theme = "gruvbox-dark-hard";
  wm = "hyprland";
  browser = "brave";
  term = "alacritty";
  editor = "neovide";
};
```

### Adding New Packages
1. Use the package management script:
   ```bash
   ./scripts/manage-packages.sh add <package-name> <category>
   ```

2. Or manually edit `modules/packages.nix`:
   ```nix
   # Add to appropriate category
   your-package-name
   ```

3. Rebuild the system:
   ```bash
   sudo nixos-rebuild switch --flake .#novanix
   ```

### Adding New Themes
1. Create theme directory in `themes/`
2. Add theme configuration files
3. Update theme listing script if needed
4. Switch to the new theme

## 🐛 Troubleshooting

### Common Issues

#### Build Failures
```bash
# Check for syntax errors
nix flake check

# Dry run build
nix build .#nixosConfigurations.novanix.config.system.build.toplevel --dry-run
```

#### Package Issues
```bash
# Check package availability
nix search nixpkgs <package-name>

# Verify package name
nix-env -qaP | grep <package-name>
```

#### Theme Issues
```bash
# Regenerate theme cache
stylix generate

# Check theme files
ls -la ~/.config/stylix/
```

#### NVIDIA Issues
```bash
# Check driver status
nvidia-smi

# Verify kernel modules
lsmod | grep nvidia

# Check X11/Wayland compatibility
echo $XDG_SESSION_TYPE
```

### Debugging Commands
```bash
# View system logs
journalctl -f

# Check system status
systemctl status

# Verify configuration
nixos-option <option-path>
```

### Recovery
```bash
# Boot into previous generation
sudo nixos-rebuild boot --flake .#novanix

# Rollback to previous configuration
sudo nixos-rebuild switch --rollback

# Emergency mode
# Boot with systemd.unit=emergency.target
```

## 🤝 Contributing

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Code Style
- Use consistent indentation (2 spaces)
- Add comments for complex configurations
- Follow NixOS best practices
- Test changes before committing

### Testing
```bash
# Test configuration syntax
nix flake check

# Build configuration
nix build .#nixosConfigurations.novanix.config.system.build.toplevel

# Test in VM (if available)
nixos-rebuild build-vm --flake .#novanix
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **NixOS Community**: For the excellent documentation and support
- **Stylix**: For the comprehensive theming system
- **Hyprland**: For the modern Wayland compositor
- **Theme Authors**: For the beautiful color schemes

## 📞 Support

- **Issues**: Report bugs and feature requests on GitHub
- **Discussions**: Join community discussions
- **Documentation**: Check the [Wiki](wiki-link) for detailed guides

---

**Note**: This configuration is actively maintained and updated. Always backup your system before making changes and test configurations in a safe environment first. 