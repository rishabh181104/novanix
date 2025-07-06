# Quick Start Guide

Get up and running with Novanix in minutes! This guide provides the essential steps to install and configure your system.

## 🚀 Quick Installation

### Prerequisites
- NixOS system
- NVIDIA GPU (recommended)
- Internet connection
- Git installed

### Step 1: Clone and Configure
```bash
# Clone the repository
git clone https://github.com/yourusername/novanix.git
cd novanix

# Edit system settings (REQUIRED)
nano flake.nix
```

**Update these settings in `flake.nix`:**
```nix
systemSettings = {
  hostname = "your-hostname";     # Change this
  timezone = "Your/Timezone";     # Change this
  # Keep other settings as is
};

userSettings = {
  username = "your-username";     # Change this
  name = "Your Full Name";        # Change this
  email = "your.email@example.com"; # Change this
  # Keep other settings as is
};
```

### Step 2: Build and Install
```bash
# Build and switch to the new configuration
sudo nixos-rebuild switch --flake .#novanix
```

### Step 3: Reboot and Enjoy!
```bash
# Reboot to apply all changes
sudo reboot
```

## 🎨 Quick Theme Customization

### List Available Themes
```bash
./scripts/list-themes.sh
```

### Switch Theme
```bash
# Switch to a different theme
./scripts/switch-theme.sh catppuccin-mocha

# Rebuild to apply
sudo nixos-rebuild switch --flake .#novanix
```

## 📦 Quick Package Management

### List All Packages
```bash
./scripts/manage-packages.sh list
```

### Add a Package
```bash
# Add a new package
./scripts/manage-packages.sh add firefox BROWSERS

# Rebuild to install
sudo nixos-rebuild switch --flake .#novanix
```

### Remove a Package
```bash
# Remove a package
./scripts/manage-packages.sh remove spotify

# Rebuild to apply
sudo nixos-rebuild switch --flake .#novanix
```

## 🔧 Essential Commands

### System Management
```bash
# Update system
nix flake update
sudo nixos-rebuild switch --flake .#novanix

# Rollback if needed
sudo nixos-rebuild switch --rollback

# Check system status
systemctl status
```

### Package Management
```bash
# Search for packages
./scripts/manage-packages.sh search <package-name>

# Backup package configuration
./scripts/manage-packages.sh backup

# Restore from backup
./scripts/manage-packages.sh restore
```

### Theme Management
```bash
# List themes
./scripts/list-themes.sh

# Switch themes
./scripts/switch-theme.sh <theme-name>

# Generate theme integration guide
./scripts/stylix-integration.sh
```

## 🎯 What You Get

### Desktop Environment
- **Hyprland**: Modern Wayland compositor
- **Waybar**: Customizable status bar
- **Wlogout**: Secure logout menu
- **Mako**: Desktop notifications

### Applications
- **Terminals**: Alacritty, Foot, Kitty
- **Editors**: Neovim, Cursor, Zed
- **Browsers**: Brave, Chrome
- **Media**: Spotify, VLC, Discord
- **Office**: LibreOffice, Thunderbird

### Development Tools
- **Languages**: Python, Node.js, Go, Rust, Lua
- **Tools**: Git, GDB, debugpy, language servers
- **Virtualization**: QEMU, virt-manager

### Theming
- **50+ Themes**: From classic to modern
- **Automatic Integration**: Themes applied across applications
- **Font Management**: Consistent typography

## 🚨 Troubleshooting

### Common Issues

#### Build Fails
```bash
# Check for errors
nix flake check

# View detailed error
nix build .#nixosConfigurations.novanix.config.system.build.toplevel --show-trace
```

#### Package Not Found
```bash
# Search for package
nix search nixpkgs <package-name>

# Check if it exists
nix-env -qaP | grep <package-name>
```

#### Theme Not Applying
```bash
# Regenerate theme cache
stylix generate

# Check theme files
ls -la ~/.config/stylix/
```

### Emergency Recovery
```bash
# Boot into previous generation
sudo nixos-rebuild boot --flake .#novanix

# Emergency mode
# Add systemd.unit=emergency.target to kernel parameters
```

## 📚 Next Steps

### Customization
1. **Explore Themes**: Try different themes with `./scripts/list-themes.sh`
2. **Add Packages**: Use `./scripts/manage-packages.sh add <package>`
3. **Configure Applications**: Edit configuration files in `modules/`
4. **Create Custom Themes**: Add your own themes to `themes/`

### Learning Resources
- **README.md**: Comprehensive overview
- **docs/INSTALLATION.md**: Detailed installation guide
- **docs/MODULES.md**: Module documentation
- **docs/THEMING.md**: Theming guide
- **docs/MAINTENANCE.md**: Maintenance procedures

### Community
- **GitHub Issues**: Report bugs and request features
- **Discussions**: Join community discussions
- **Contributing**: Share improvements

## ⚡ Performance Tips

### Quick Optimizations
```bash
# Enable performance mode
sudo nixos-rebuild switch --flake .#novanix

# Clean up old generations
sudo nix-collect-garbage -d

# Optimize disk usage
sudo fstrim -av
```

### System Monitoring
```bash
# Check system resources
htop

# Monitor disk usage
df -h

# Check memory usage
free -h
```

## 🔒 Security

### Basic Security
- Firewall is enabled by default
- SSH is configured securely
- Regular updates recommended
- User permissions properly set

### Security Updates
```bash
# Update system regularly
nix flake update
sudo nixos-rebuild switch --flake .#novanix

# Check for security issues
nix audit
```

## 📞 Support

### Getting Help
1. **Check Documentation**: Review this guide and other docs
2. **Search Issues**: Look for similar problems
3. **Create Issue**: Report bugs with details
4. **Community**: Join discussions

### Useful Commands
```bash
# System information
inxi -Fxxxz

# Check logs
journalctl -f

# Check services
systemctl status

# Check hardware
lspci | grep -i vga
```

---

**That's it!** You should now have a fully functional Novanix system. Explore the themes, customize your setup, and enjoy your new NixOS configuration!

For detailed information, check out the full documentation in the `docs/` directory. 