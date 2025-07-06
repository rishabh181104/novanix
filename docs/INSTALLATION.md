# Installation Guide

This guide provides detailed instructions for installing and setting up Novanix on your system.

## Prerequisites

### System Requirements
- **Architecture**: x86_64-linux
- **RAM**: Minimum 8GB (16GB recommended)
- **Storage**: 50GB available space
- **Graphics**: NVIDIA GPU (GTX 1060 or better)
- **Boot Mode**: UEFI (recommended)

### Software Requirements
- **NixOS**: Latest stable or unstable release
- **Git**: For cloning the repository
- **Internet Connection**: For downloading packages

## Installation Steps

### Step 1: System Preparation

#### 1.1 Update Current System
```bash
# Update your current NixOS system
sudo nixos-rebuild switch --upgrade

# Clean up old generations
sudo nix-collect-garbage -d
```

#### 1.2 Install Required Tools
```bash
# Install git if not already installed
sudo nix-env -iA nixpkgs.git

# Install additional tools for development
sudo nix-env -iA nixpkgs.curl nixpkgs.wget
```

### Step 2: Repository Setup

#### 2.1 Clone the Repository
```bash
# Navigate to your home directory
cd ~

# Clone the Novanix repository
git clone https://github.com/yourusername/novanix.git

# Navigate to the repository
cd novanix
```

#### 2.2 Verify Repository Structure
```bash
# Check the repository structure
ls -la

# Verify key files exist
ls -la flake.nix configuration.nix modules/
```

### Step 3: System Configuration

#### 3.1 Update System Settings
Edit `flake.nix` to match your system:

```nix
systemSettings = {
  system = "x86_64-linux";        # Keep as is
  hostname = "your-hostname";     # Change to your hostname
  timezone = "Your/Timezone";     # Change to your timezone
  locale = "en_US.UTF-8";         # Keep as is or change
  bootMode = "uefi";              # Change to "bios" if using legacy boot
  bootMountPath = "/boot";        # Keep as is
  gpuType = "nvidia";             # Change to "amd" or "intel" if different
};
```

#### 3.2 Update User Settings
Modify the user configuration in `flake.nix`:

```nix
userSettings = {
  username = "your-username";           # Your username
  name = "Your Full Name";              # Your full name
  email = "your.email@example.com";     # Your email
  dotfilesDir = "~/novanix";            # Keep as is
  theme = "gruvbox-dark-hard";          # Choose your preferred theme
  wm = "hyprland";                      # Keep as is
  wmType = "wayland";                   # Keep as is
  browser = "brave";                    # Choose your browser
  term = "alacritty";                   # Choose your terminal
  editor = "neovide";                   # Choose your editor
};
```

#### 3.3 Hardware Configuration
Update `hardware.nix` to match your system:

```bash
# Generate hardware configuration (if needed)
sudo nixos-generate-config --show-hardware-config > hardware.nix.new

# Compare with existing hardware.nix
diff hardware.nix hardware.nix.new

# Update if necessary
cp hardware.nix.new hardware.nix
```

### Step 4: Package Customization

#### 4.1 Review Packages
Check the packages in `modules/packages.nix`:

```bash
# List all packages by category
./scripts/manage-packages.sh list

# Search for specific packages
./scripts/manage-packages.sh search firefox
```

#### 4.2 Add/Remove Packages
```bash
# Add a package
./scripts/manage-packages.sh add firefox BROWSERS

# Remove a package
./scripts/manage-packages.sh remove spotify

# Create backup before changes
./scripts/manage-packages.sh backup
```

### Step 5: Theme Selection

#### 5.1 List Available Themes
```bash
# List all available themes
./scripts/list-themes.sh

# Preview theme names
ls themes/
```

#### 5.2 Choose and Set Theme
```bash
# Switch to a different theme
./scripts/switch-theme.sh catppuccin-mocha

# Or manually edit flake.nix
# Change theme in userSettings
```

### Step 6: System Build

#### 6.1 Dry Run Build
```bash
# Test the configuration without applying
nix build .#nixosConfigurations.novanix.config.system.build.toplevel --dry-run
```

#### 6.2 Build and Apply
```bash
# Build and switch to the new configuration
sudo nixos-rebuild switch --flake .#novanix

# Or build without switching
sudo nixos-rebuild build --flake .#novanix
```

### Step 7: Post-Installation Setup

#### 7.1 Verify Installation
```bash
# Check system status
systemctl status

# Verify user account
whoami
groups

# Check graphics drivers
nvidia-smi  # For NVIDIA
```

#### 7.2 Initial Configuration
```bash
# Set up git configuration
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Initialize git repository
git init
git add .
git commit -m "Initial commit"
```

#### 7.3 Theme Integration
```bash
# Generate theme integration guide
./scripts/stylix-integration.sh

# Apply theme to applications
stylix generate
```

## Configuration Options

### Network Configuration
Edit `modules/network.nix` for network settings:

```nix
networking = {
  networkmanager.enable = true;
  firewall.enable = true;
  # Add your network interfaces here
};
```

### Display Manager
Configure display manager in `modules/dm.nix`:

```nix
services.displayManager = {
  gdm.enable = true;  # For GNOME
  # or
  sddm.enable = true; # For KDE
  # or
  lightdm.enable = true; # For lightweight
};
```

### Additional Services
Enable services in `modules/services.nix`:

```nix
services = {
  openssh.enable = true;
  printing.enable = true;
  blueman.enable = true;
};
```

## Troubleshooting

### Common Issues

#### Build Failures
```bash
# Check for syntax errors
nix flake check

# View detailed error messages
nix build .#nixosConfigurations.novanix.config.system.build.toplevel --show-trace
```

#### Package Not Found
```bash
# Search for package in nixpkgs
nix search nixpkgs <package-name>

# Check if package exists
nix-env -qaP | grep <package-name>
```

#### Graphics Issues
```bash
# Check graphics driver status
lspci | grep -i vga
nvidia-smi  # For NVIDIA
glxinfo | grep "OpenGL renderer"  # For general graphics
```

#### Boot Issues
```bash
# Boot into previous generation
sudo nixos-rebuild boot --flake .#novanix

# Emergency mode
# Add systemd.unit=emergency.target to kernel parameters
```

### Recovery Procedures

#### Rollback Configuration
```bash
# List available generations
nix-env --list-generations -p /nix/var/nix/profiles/system

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# Boot into specific generation
sudo nixos-rebuild boot --flake .#novanix
```

#### Reset to Default
```bash
# Remove current configuration
sudo rm -rf /etc/nixos/*

# Restore from backup
sudo cp -r ~/novanix-backup/* /etc/nixos/

# Rebuild
sudo nixos-rebuild switch
```

## Advanced Configuration

### Custom Modules
Create custom modules in `modules/`:

```nix
# modules/custom.nix
{ config, pkgs, ... }:

{
  # Your custom configuration
  environment.systemPackages = with pkgs; [
    your-custom-package
  ];
}
```

### Override Packages
Override packages in `flake.nix`:

```nix
nixpkgs.overlays = [
  (self: super: {
    your-package = super.your-package.override {
      # Your overrides
    };
  })
];
```

### Custom Themes
Add custom themes to `themes/`:

```bash
# Create theme directory
mkdir themes/my-custom-theme

# Add theme files
touch themes/my-custom-theme/default.nix
touch themes/my-custom-theme/palette.nix
```

## Maintenance

### Regular Updates
```bash
# Update flake inputs
nix flake update

# Rebuild system
sudo nixos-rebuild switch --flake .#novanix

# Clean up old generations
sudo nix-collect-garbage -d
```

### Backup Configuration
```bash
# Create backup
tar -czf novanix-backup-$(date +%Y%m%d).tar.gz .

# Restore from backup
tar -xzf novanix-backup-YYYYMMDD.tar.gz
```

### Package Management
```bash
# Update package list
./scripts/manage-packages.sh backup
# Edit packages.nix
./scripts/manage-packages.sh rebuild
```

## Support

If you encounter issues:

1. **Check Documentation**: Review this guide and README.md
2. **Search Issues**: Look for similar issues in the repository
3. **Create Issue**: Report bugs with detailed information
4. **Community**: Join NixOS community discussions

## Next Steps

After successful installation:

1. **Customize Themes**: Explore and switch between themes
2. **Configure Applications**: Set up your preferred applications
3. **Development Setup**: Configure your development environment
4. **Backup**: Create regular backups of your configuration
5. **Contribute**: Share improvements with the community 