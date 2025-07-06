# Module Documentation

This document provides detailed information about each module in the Novanix configuration, including their purpose, configuration options, and usage examples.

## Table of Contents

- [Core Modules](#core-modules)
- [System Modules](#system-modules)
- [Hardware Modules](#hardware-modules)
- [Application Modules](#application-modules)
- [Service Modules](#service-modules)
- [Custom Modules](#custom-modules)

## Core Modules

### `packages.nix`
**Purpose**: Centralized package management for the entire system.

**Key Features**:
- All system packages organized by functional categories
- Easy to maintain and update
- Single source of truth for package management

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ===== TERMINAL APPLICATIONS =====
    alacritty
    foot
    kitty
    
    # ===== SHELL AND UTILITIES =====
    fish
    starship
    bash
    
    # ... more packages organized by category
  ];
}
```

**Usage**:
```bash
# List all packages by category
./scripts/manage-packages.sh list

# Add a new package
./scripts/manage-packages.sh add firefox BROWSERS

# Remove a package
./scripts/manage-packages.sh remove spotify
```

**Categories**:
- Terminal Applications
- Shell and Utilities
- Editors and IDEs
- Development Tools
- Wayland and Desktop
- Browsers
- Media and Entertainment
- Office and Productivity
- System Utilities
- File System Support
- Bluetooth
- NVIDIA and Vulkan
- Virtual Machines

### `stylix.nix`
**Purpose**: Comprehensive theming configuration using Stylix.

**Key Features**:
- Automatic theme application across applications
- Font configuration and management
- Integration with 50+ pre-configured themes
- Support for terminals, editors, browsers, and desktop components

**Configuration**:
```nix
{ config, pkgs, stylix, userSettings, ... }:

{
  stylix = {
    image = ../../wallpapers/your-wallpaper.jpg;
    base16Scheme = with stylix.colorSchemes; gruvbox-dark-hard;
    fonts = {
      serif = with pkgs; { package = noto-fonts; name = "Noto Serif"; };
      sansSerif = with pkgs; { package = noto-fonts; name = "Noto Sans"; };
      monospace = with pkgs; { package = jetbrains-mono; name = "JetBrains Mono"; };
      emoji = with pkgs; { package = noto-fonts-emoji; name = "Noto Color Emoji"; };
    };
  };
}
```

**Theme Integration**:
- **Terminals**: Alacritty, Kitty, Foot
- **Desktop Components**: Waybar, Wlogout, Mako
- **Editors**: Neovim, Cursor, Helix
- **Browsers**: Brave, Chrome
- **System Components**: GTK, QT applications

**Usage**:
```bash
# List available themes
./scripts/list-themes.sh

# Switch themes
./scripts/switch-theme.sh <theme-name>

# Generate integration guide
./scripts/stylix-integration.sh
```

## System Modules

### `network.nix`
**Purpose**: Network configuration and management.

**Key Features**:
- NetworkManager for network management
- Firewall configuration
- DHCP and static IP support
- Network interface configuration

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
      allowedUDPPorts = [ 53 67 ];
    };
    useDHCP = true;
  };
  
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" "en_IN/UTF-8" ];
  };
}
```

**Network Interfaces**:
```nix
networking.interfaces = {
  enp0s31f6 = {
    useDHCP = true;
  };
  wlp0s20f3 = {
    useDHCP = true;
  };
};
```

### `services.nix`
**Purpose**: System services configuration.

**Key Features**:
- SSH server configuration
- Printing services
- Audio system setup
- Systemd services management

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
    
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
    
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };
}
```

### `user.nix`
**Purpose**: User account and shell configuration.

**Key Features**:
- User account creation and configuration
- Shell setup (Fish shell)
- Group membership
- User-specific packages

**Configuration**:
```nix
{ config, pkgs, userSettings, systemSettings, ... }:

{
  time.timeZone = systemSettings.timezone;
  users.users.${userSettings.username} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "kvm" ];
  };
  
  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
}
```

### `power.nix`
**Purpose**: Power management configuration.

**Key Features**:
- TLP power management
- CPU frequency scaling
- Battery optimization
- Power saving features

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_MIN_FREQ_ON_AC = 800000;
      CPU_SCALING_MAX_FREQ_ON_AC = 3000000;
      CPU_SCALING_MIN_FREQ_ON_BAT = 400000;
      CPU_SCALING_MAX_FREQ_ON_BAT = 2000000;
    };
  };
}
```

## Hardware Modules

### `nvidia.nix`
**Purpose**: NVIDIA graphics driver and configuration.

**Key Features**:
- Proprietary NVIDIA driver setup
- Power management
- Vulkan support
- PRIME offload for hybrid graphics
- Modesetting for Wayland support

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  hardware.nvidia = {
    open = false;
    powerManagement.enable = true;
    modesetting.enable = true;
    prime = {
      offload.enable = false;
      # sync.enable = true;
    };
    nvidiaPersistenced = true;
  };
  
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia.NVreg_UsePageAttributeTable=1"
  ];
}
```

**Vulkan Support**:
```nix
environment.systemPackages = with pkgs; [
  vulkan-loader
  vulkan-tools
  vulkan-validation-layers
];
```

### `hardware.nix`
**Purpose**: Hardware-specific configuration.

**Key Features**:
- Hardware detection and configuration
- File system setup
- Boot configuration
- Kernel modules

**Configuration**:
```nix
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/your-uuid";
    fsType = "ext4";
  };
  
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/your-boot-uuid";
    fsType = "vfat";
  };
}
```

## Application Modules

### `wayland.nix`
**Purpose**: Wayland and Hyprland desktop environment.

**Key Features**:
- Hyprland compositor setup
- XDG portal configuration
- QT6 and GTK integration
- Desktop environment components

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
```

**Desktop Components**:
```nix
environment.systemPackages = with pkgs; [
  hyprland
  hypridle
  hyprlock
  waybar
  wlogout
  mako
  swww
  rose-pine-hyprcursor
];
```

### `terminal.nix`
**Purpose**: Terminal emulator configuration.

**Key Features**:
- Multiple terminal emulators
- Terminal utilities
- Shell integration

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  # Terminal emulators and utilities
  # Packages are managed in packages.nix
}
```

**Available Terminals**:
- Alacritty (GPU-accelerated)
- Foot (Wayland-native)
- Kitty (GPU-accelerated with features)

### `editors.nix`
**Purpose**: Text editor and IDE configuration.

**Key Features**:
- Multiple text editors
- Development environments
- Code formatting tools

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  # Text editors and IDEs
  # Packages are managed in packages.nix
}
```

**Available Editors**:
- Neovim (Vim-based)
- Cursor (VS Code-based)
- Zed Editor (Modern editor)
- Vim (Classic editor)

### `dev.nix`
**Purpose**: Development environment setup.

**Key Features**:
- Multiple programming languages
- Language servers
- Debugging tools
- Code formatting

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  # Development tools and languages
  # Packages are managed in packages.nix
}
```

**Development Stack**:
- **Languages**: Python, Node.js, Go, Rust, Lua
- **Language Servers**: TypeScript, Python, Lua, Java, SQL
- **Tools**: Git, GDB, debugpy, formatting tools
- **Databases**: PostgreSQL

### `browser.nix`
**Purpose**: Web browser configuration.

**Key Features**:
- Multiple browser options
- Browser-specific settings

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  # Web browsers
  # Packages are managed in packages.nix
}
```

**Available Browsers**:
- Brave (Privacy-focused)
- Google Chrome (Feature-rich)
- Firefox (Open source)

### `bluetooth.nix`
**Purpose**: Bluetooth device management.

**Key Features**:
- Bluetooth device support
- Audio device management
- Device pairing

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  # Bluetooth management tools
  # Packages are managed in packages.nix
}
```

**Bluetooth Tools**:
- Blueman (GUI manager)
- Bluez (Core bluetooth stack)
- Bluez-tools (Command line tools)

## Service Modules

### `virtual-machine.nix`
**Purpose**: Virtualization support.

**Key Features**:
- QEMU/KVM virtualization
- Virt-manager GUI
- SPICE support
- USB redirection

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
      };
    };
  };
}
```

**Virtualization Tools**:
- QEMU (Emulator)
- Libvirt (Virtualization API)
- Virt-manager (GUI)
- Virt-viewer (Remote viewer)
- SPICE (Remote desktop)

### `firewall.nix`
**Purpose**: Firewall configuration.

**Key Features**:
- Network security
- Port management
- Service protection

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];
    allowedUDPPorts = [ 53 67 ];
  };
}
```

### `fonts.nix`
**Purpose**: Font configuration and management.

**Key Features**:
- System font installation
- Font rendering configuration
- Unicode support

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
}
```

### `dm.nix`
**Purpose**: Display manager configuration.

**Key Features**:
- Login screen setup
- Session management
- Display manager selection

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  services.displayManager = {
    gdm.enable = true;  # GNOME Display Manager
    # sddm.enable = true;  # KDE Display Manager
    # lightdm.enable = true;  # Lightweight Display Manager
  };
}
```

### `xorg.nix`
**Purpose**: X11 configuration (fallback).

**Key Features**:
- X11 server setup
- Input device configuration
- Display settings

**Configuration**:
```nix
{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
  };
}
```

## Custom Modules

### Creating Custom Modules

To create a custom module:

1. **Create the module file**:
```bash
touch modules/custom.nix
```

2. **Add configuration**:
```nix
# modules/custom.nix
{ config, pkgs, ... }:

{
  # Your custom configuration
  environment.systemPackages = with pkgs; [
    your-custom-package
  ];
  
  services.your-service = {
    enable = true;
    settings = {
      # Your settings
    };
  };
}
```

3. **Import in configuration.nix**:
```nix
imports = [
  # ... other imports
  ./modules/custom.nix
];
```

### Module Best Practices

1. **Single Responsibility**: Each module should have a single, well-defined purpose
2. **Documentation**: Include comments explaining the purpose and configuration options
3. **Error Handling**: Use proper error handling and validation
4. **Consistency**: Follow the established naming and structure conventions
5. **Testing**: Test modules individually before integration

### Module Dependencies

When modules depend on each other:

```nix
# modules/dependent.nix
{ config, pkgs, ... }:

let
  # Access configuration from other modules
  userConfig = config.users.users.${config.userSettings.username};
  networkConfig = config.networking;
in {
  # Use the configuration from other modules
  services.my-service = {
    enable = true;
    user = userConfig.name;
    network = networkConfig.hostName;
  };
}
```

## Module Management

### Adding New Modules

1. Create the module file in `modules/`
2. Add configuration following the established patterns
3. Import the module in `configuration.nix`
4. Test the configuration
5. Document the module

### Removing Modules

1. Remove the import from `configuration.nix`
2. Delete the module file
3. Update documentation
4. Test the configuration

### Updating Modules

1. Backup the current module
2. Make changes incrementally
3. Test after each change
4. Update documentation
5. Commit changes with descriptive messages

## Troubleshooting Modules

### Common Issues

#### Module Not Loading
```bash
# Check import path
nix flake check

# Verify module syntax
nix-instantiate --eval modules/your-module.nix
```

#### Configuration Conflicts
```bash
# Check for conflicting options
nixos-option <option-path>

# View module evaluation
nix build .#nixosConfigurations.novanix.config.system.build.toplevel --show-trace
```

#### Package Issues
```bash
# Check package availability
nix search nixpkgs <package-name>

# Verify package name
nix-env -qaP | grep <package-name>
```

### Debugging Tips

1. **Use `--show-trace`** for detailed error information
2. **Check module evaluation** with `nix-instantiate`
3. **Verify option values** with `nixos-option`
4. **Test modules individually** before integration
5. **Use dry-run builds** to catch issues early

## Module Examples

### Simple Package Module
```nix
# modules/example-packages.nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    htop
    tree
    wget
  ];
}
```

### Service Configuration Module
```nix
# modules/example-service.nix
{ config, pkgs, ... }:

{
  services.example = {
    enable = true;
    port = 8080;
    settings = {
      debug = true;
      logLevel = "info";
    };
  };
}
```

### User Configuration Module
```nix
# modules/example-user.nix
{ config, pkgs, userSettings, ... }:

{
  users.users.${userSettings.username} = {
    extraGroups = [ "docker" "vboxusers" ];
    packages = with pkgs; [
      docker
      virtualbox
    ];
  };
}
```

This documentation provides a comprehensive guide to understanding and working with the Novanix module system. Each module is designed to be modular, maintainable, and well-documented for easy customization and extension. 