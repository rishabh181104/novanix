# Documentation Index

Welcome to the Novanix documentation! This index will help you find the information you need quickly and efficiently.

## 📚 Documentation Overview

### Getting Started
- **[Quick Start Guide](QUICKSTART.md)** - Get up and running in minutes
- **[Installation Guide](INSTALLATION.md)** - Detailed installation instructions
- **[README.md](../README.md)** - Comprehensive project overview

### Configuration & Customization
- **[Module Documentation](MODULES.md)** - Detailed guide to all configuration modules
- **[Theming Guide](THEMING.md)** - Complete theming system documentation
- **[Maintenance Guide](MAINTENANCE.md)** - System maintenance and optimization

## 🎯 Quick Navigation

### I'm New Here
1. **Start with**: [Quick Start Guide](QUICKSTART.md)
2. **Then read**: [README.md](../README.md)
3. **For installation**: [Installation Guide](INSTALLATION.md)

### I Want to Customize
1. **Themes**: [Theming Guide](THEMING.md)
2. **Packages**: [Module Documentation](MODULES.md) → `packages.nix`
3. **Configuration**: [Module Documentation](MODULES.md)

### I Need Help
1. **Troubleshooting**: [Maintenance Guide](MAINTENANCE.md) → Troubleshooting section
2. **System Issues**: [Installation Guide](INSTALLATION.md) → Troubleshooting section
3. **Theme Issues**: [Theming Guide](THEMING.md) → Troubleshooting section

### I Want to Learn More
1. **Architecture**: [Module Documentation](MODULES.md)
2. **Advanced Usage**: [Maintenance Guide](MAINTENANCE.md)
3. **Custom Development**: [Module Documentation](MODULES.md) → Custom Modules

## 📖 Documentation Structure

```
docs/
├── INDEX.md              # This file - Documentation index
├── QUICKSTART.md         # Quick start guide
├── INSTALLATION.md       # Detailed installation guide
├── MODULES.md            # Module documentation
├── THEMING.md            # Theming system guide
└── MAINTENANCE.md        # Maintenance and troubleshooting
```

## 🔍 Finding What You Need

### By Topic

#### Installation & Setup
- **First Time Setup**: [Quick Start Guide](QUICKSTART.md)
- **Detailed Installation**: [Installation Guide](INSTALLATION.md)
- **Hardware Configuration**: [Installation Guide](INSTALLATION.md) → Hardware Configuration
- **Post-Installation**: [Installation Guide](INSTALLATION.md) → Post-Installation Setup

#### Configuration
- **System Settings**: [Installation Guide](INSTALLATION.md) → System Configuration
- **User Settings**: [Installation Guide](INSTALLATION.md) → User Configuration
- **Network Setup**: [Module Documentation](MODULES.md) → `network.nix`
- **Graphics Configuration**: [Module Documentation](MODULES.md) → `nvidia.nix`

#### Package Management
- **Adding Packages**: [Quick Start Guide](QUICKSTART.md) → Quick Package Management
- **Package Categories**: [Module Documentation](MODULES.md) → `packages.nix`
- **Custom Packages**: [Module Documentation](MODULES.md) → Custom Modules
- **Package Scripts**: [Maintenance Guide](MAINTENANCE.md) → Package Management

#### Theming
- **Available Themes**: [Theming Guide](THEMING.md) → Available Themes
- **Theme Switching**: [Quick Start Guide](QUICKSTART.md) → Quick Theme Customization
- **Custom Themes**: [Theming Guide](THEMING.md) → Customization
- **Application Integration**: [Theming Guide](THEMING.md) → Application Integration

#### Maintenance
- **Regular Updates**: [Maintenance Guide](MAINTENANCE.md) → System Updates
- **Backup Strategies**: [Maintenance Guide](MAINTENANCE.md) → Backup Strategies
- **Performance Optimization**: [Maintenance Guide](MAINTENANCE.md) → Performance Optimization
- **Troubleshooting**: [Maintenance Guide](MAINTENANCE.md) → Troubleshooting

### By Experience Level

#### Beginner
1. [Quick Start Guide](QUICKSTART.md)
2. [README.md](../README.md)
3. [Installation Guide](INSTALLATION.md)

#### Intermediate
1. [Module Documentation](MODULES.md)
2. [Theming Guide](THEMING.md)
3. [Maintenance Guide](MAINTENANCE.md)

#### Advanced
1. [Module Documentation](MODULES.md) → Custom Modules
2. [Maintenance Guide](MAINTENANCE.md) → Advanced Configuration
3. [Theming Guide](THEMING.md) → Advanced Configuration

## 🛠️ Common Tasks

### Quick Commands Reference

#### System Management
```bash
# Update system
nix flake update && sudo nixos-rebuild switch --flake .#novanix

# Rollback
sudo nixos-rebuild switch --rollback

# Check status
systemctl status
```

#### Package Management
```bash
# List packages
./scripts/manage-packages.sh list

# Add package
./scripts/manage-packages.sh add <package> <category>

# Remove package
./scripts/manage-packages.sh remove <package>
```

#### Theme Management
```bash
# List themes
./scripts/list-themes.sh

# Switch theme
./scripts/switch-theme.sh <theme-name>

# Generate integration guide
./scripts/stylix-integration.sh
```

#### Troubleshooting
```bash
# Check configuration
nix flake check

# View errors
nix build .#nixosConfigurations.novanix.config.system.build.toplevel --show-trace

# Check logs
journalctl -f
```

## 📋 Documentation Checklist

### Before You Start
- [ ] Read [Quick Start Guide](QUICKSTART.md)
- [ ] Review [README.md](../README.md)
- [ ] Check system requirements
- [ ] Prepare backup strategy

### During Installation
- [ ] Follow [Installation Guide](INSTALLATION.md)
- [ ] Configure system settings
- [ ] Set up user account
- [ ] Test basic functionality

### After Installation
- [ ] Explore themes with [Theming Guide](THEMING.md)
- [ ] Customize packages using [Module Documentation](MODULES.md)
- [ ] Set up maintenance routine with [Maintenance Guide](MAINTENANCE.md)
- [ ] Create backups

## 🔗 External Resources

### NixOS Documentation
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Nix Package Manager](https://nixos.org/manual/nix/stable/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)

### Community Resources
- [NixOS Wiki](https://nixos.wiki/)
- [NixOS Discourse](https://discourse.nixos.org/)
- [NixOS Reddit](https://www.reddit.com/r/NixOS/)

### Related Projects
- [Stylix](https://github.com/danth/stylix) - Theming system
- [Hyprland](https://hyprland.org/) - Wayland compositor
- [Nixpkgs](https://github.com/NixOS/nixpkgs) - Package collection

## 📞 Getting Help

### Documentation Issues
- Check if your question is answered in the relevant guide
- Search through all documentation files
- Look for similar issues in the troubleshooting sections

### Technical Issues
- Check [Maintenance Guide](MAINTENANCE.md) → Troubleshooting
- Review [Installation Guide](INSTALLATION.md) → Troubleshooting
- Consult [Theming Guide](THEMING.md) → Troubleshooting

### Community Support
- Create an issue on GitHub with detailed information
- Join community discussions
- Check external resources listed above

## 📝 Contributing to Documentation

### Improving Documentation
1. **Identify gaps**: What information is missing?
2. **Write clearly**: Use simple, clear language
3. **Include examples**: Provide practical examples
4. **Test instructions**: Verify all commands work
5. **Update index**: Keep this index current

### Documentation Standards
- Use consistent formatting
- Include code examples
- Provide step-by-step instructions
- Cross-reference related topics
- Keep information current

---

**Need help finding something?** Use the search function in your browser or text editor to search across all documentation files. Most questions can be answered by searching for relevant keywords.

**Still can't find what you need?** Check the troubleshooting sections in each guide, or create an issue on GitHub with your specific question. 