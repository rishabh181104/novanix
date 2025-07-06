# Maintenance Guide

This guide covers regular maintenance tasks, system updates, backups, troubleshooting, and optimization for your Novanix NixOS configuration.

## Table of Contents

- [Regular Maintenance](#regular-maintenance)
- [System Updates](#system-updates)
- [Backup Strategies](#backup-strategies)
- [Performance Optimization](#performance-optimization)
- [Troubleshooting](#troubleshooting)
- [Recovery Procedures](#recovery-procedures)
- [Monitoring](#monitoring)

## Regular Maintenance

### Daily Tasks

#### System Health Check
```bash
# Check system status
systemctl status

# Check disk space
df -h

# Check memory usage
free -h

# Check running processes
htop
```

#### Log Monitoring
```bash
# View recent system logs
journalctl -f

# Check for errors
journalctl -p err --since "1 hour ago"

# Check boot logs
journalctl -b
```

### Weekly Tasks

#### Package Updates
```bash
# Update flake inputs
nix flake update

# Check for outdated packages
nix-env -qa --outdated

# Clean up old generations
sudo nix-collect-garbage -d
```

#### System Cleanup
```bash
# Remove old generations
sudo nix-env --delete-generations old

# Clean up temporary files
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# Clear package cache
sudo nix-store --gc
```

### Monthly Tasks

#### Full System Backup
```bash
# Create complete backup
tar -czf novanix-backup-$(date +%Y%m%d).tar.gz .

# Backup to external storage
rsync -avz ~/novanix/ /media/backup/novanix/
```

#### Configuration Review
```bash
# Review package list
./scripts/manage-packages.sh list

# Check for unused packages
nix-store --query --referrers /run/current-system

# Review system configuration
nixos-option <option-path>
```

## System Updates

### Flake Updates

#### Update Inputs
```bash
# Update all flake inputs
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs

# Check what will be updated
nix flake show
```

#### Rebuild System
```bash
# Dry run build
nix build .#nixosConfigurations.novanix.config.system.build.toplevel --dry-run

# Build and switch
sudo nixos-rebuild switch --flake .#novanix

# Build without switching
sudo nixos-rebuild build --flake .#novanix
```

### Package Updates

#### Add New Packages
```bash
# Add package using script
./scripts/manage-packages.sh add firefox BROWSERS

# Create backup before changes
./scripts/manage-packages.sh backup

# Rebuild system
./scripts/manage-packages.sh rebuild
```

#### Remove Packages
```bash
# Remove package
./scripts/manage-packages.sh remove spotify

# Verify removal
./scripts/manage-packages.sh list | grep spotify
```

### Theme Updates

#### Update Themes
```bash
# List current themes
./scripts/list-themes.sh

# Switch themes
./scripts/switch-theme.sh catppuccin-mocha

# Regenerate theme cache
stylix generate
```

## Backup Strategies

### Configuration Backup

#### Git-Based Backup
```bash
# Initialize git repository (if not already done)
git init

# Add all files
git add .

# Commit changes
git commit -m "Configuration backup $(date)"

# Push to remote repository
git push origin main
```

#### Automated Backup Script
```bash
#!/bin/bash
# scripts/backup-config.sh

BACKUP_DIR="/media/backup/novanix"
DATE=$(date +%Y%m%d_%H%M%S)

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Create backup
tar -czf "$BACKUP_DIR/novanix-$DATE.tar.gz" .

# Keep only last 10 backups
ls -t "$BACKUP_DIR"/novanix-*.tar.gz | tail -n +11 | xargs rm -f

echo "Backup completed: novanix-$DATE.tar.gz"
```

#### Incremental Backup
```bash
# Using rsync for incremental backup
rsync -avz --delete ~/novanix/ /media/backup/novanix/

# With timestamp
rsync -avz --delete ~/novanix/ "/media/backup/novanix-$(date +%Y%m%d)/"
```

### System State Backup

#### Generation Backup
```bash
# List current generations
nix-env --list-generations -p /nix/var/nix/profiles/system

# Create generation backup
sudo nix-env --export -p /nix/var/nix/profiles/system > system-generation-backup.nix

# Restore from backup
sudo nix-env --import system-generation-backup.nix
```

#### Full System Backup
```bash
# Create system image backup
sudo nixos-rebuild build-vm --flake .#novanix

# Backup /etc/nixos
sudo tar -czf etc-nixos-backup.tar.gz /etc/nixos/

# Backup user data
tar -czf home-backup.tar.gz ~/
```

## Performance Optimization

### System Optimization

#### Kernel Optimization
```nix
# modules/performance.nix
{ config, pkgs, ... }:

{
  boot.kernelParams = [
    "intel_pstate=performance"
    "i915.enable_guc=2"
    "i915.enable_fbc=1"
  ];
  
  powerManagement.cpuFreqGovernor = "performance";
}
```

#### Memory Optimization
```nix
# Enable zram for memory compression
zramSwap.enable = true;

# Optimize swappiness
boot.kernelParams = [ "vm.swappiness=10" ];
```

#### Disk Optimization
```nix
# Enable TRIM for SSDs
services.fstrim.enable = true;

# Optimize file system
fileSystems."/".options = [ "noatime" "nodiratime" ];
```

### Application Optimization

#### Terminal Performance
```nix
# Optimize terminal rendering
programs.alacritty.settings = {
  renderer = "gpu";
  gpu_acceleration = "Vulkan";
};
```

#### Browser Optimization
```nix
# Enable hardware acceleration
environment.variables = {
  MOZ_ENABLE_WAYLAND = "1";
  CHROME_EXTRA_ARGS = "--enable-features=Vulkan";
};
```

### Network Optimization

#### Network Tuning
```nix
# Optimize network performance
networking.tcpcrypt.enable = true;

# Enable BBR congestion control
boot.kernelParams = [ "net.core.default_qdisc=fq" "net.ipv4.tcp_congestion_control=bbr" ];
```

## Troubleshooting

### Common Issues

#### Build Failures
```bash
# Check for syntax errors
nix flake check

# View detailed error messages
nix build .#nixosConfigurations.novanix.config.system.build.toplevel --show-trace

# Check flake lock
nix flake lock --recreate-lock-file
```

#### Package Issues
```bash
# Check package availability
nix search nixpkgs <package-name>

# Verify package name
nix-env -qaP | grep <package-name>

# Check package dependencies
nix-store --query --tree $(which <package-name>)
```

#### Graphics Issues
```bash
# Check graphics driver status
nvidia-smi  # For NVIDIA
lspci | grep -i vga  # General graphics info

# Check Wayland/X11 compatibility
echo $XDG_SESSION_TYPE

# Check display manager
systemctl status display-manager
```

#### Network Issues
```bash
# Check network status
systemctl status NetworkManager

# Check network interfaces
ip addr show

# Test connectivity
ping -c 4 8.8.8.8
```

### Debugging Tools

#### System Information
```bash
# System information
inxi -Fxxxz

# Hardware information
lshw -short

# Kernel information
uname -a
```

#### Log Analysis
```bash
# View system logs
journalctl -f

# Check boot logs
journalctl -b

# Check specific service logs
journalctl -u <service-name>
```

#### Performance Monitoring
```bash
# System resources
htop
iotop
nethogs

# Disk usage
ncdu
du -sh /*

# Memory usage
free -h
cat /proc/meminfo
```

## Recovery Procedures

### System Recovery

#### Rollback to Previous Generation
```bash
# List available generations
nix-env --list-generations -p /nix/var/nix/profiles/system

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# Boot into specific generation
sudo nixos-rebuild boot --flake .#novanix
```

#### Emergency Mode
```bash
# Boot into emergency mode
# Add to kernel parameters: systemd.unit=emergency.target

# Mount file systems
mount -o remount,rw /
mount -a

# Fix configuration
nano /etc/nixos/configuration.nix

# Rebuild
nixos-rebuild switch
```

#### Complete Reset
```bash
# Remove current configuration
sudo rm -rf /etc/nixos/*

# Restore from backup
sudo cp -r ~/novanix-backup/* /etc/nixos/

# Rebuild system
sudo nixos-rebuild switch
```

### Data Recovery

#### File Recovery
```bash
# Use testdisk for file recovery
sudo testdisk

# Use photorec for photo recovery
sudo photorec

# Use extundelete for ext4 recovery
sudo extundelete /dev/sdX --restore-all
```

#### Configuration Recovery
```bash
# Restore from git
git log --oneline
git checkout <commit-hash>

# Restore from backup
tar -xzf novanix-backup-YYYYMMDD.tar.gz

# Restore specific files
cp backup/modules/packages.nix modules/
```

## Monitoring

### System Monitoring

#### Resource Monitoring
```bash
# CPU usage
top
htop

# Memory usage
free -h
cat /proc/meminfo

# Disk usage
df -h
du -sh /*

# Network usage
iftop
nethogs
```

#### Service Monitoring
```bash
# Check service status
systemctl status

# Monitor specific services
systemctl status NetworkManager
systemctl status display-manager

# Check failed services
systemctl --failed
```

### Log Monitoring

#### Log Analysis
```bash
# Monitor logs in real-time
journalctl -f

# Check for errors
journalctl -p err --since "1 hour ago"

# Check specific service logs
journalctl -u <service-name> -f
```

#### Log Rotation
```nix
# Configure log rotation
services.logrotate = {
  enable = true;
  settings = {
    "/var/log/*.log" = {
      rotate = 7;
      daily = true;
      compress = true;
      missingok = true;
      notifempty = true;
    };
  };
};
```

### Automated Monitoring

#### Monitoring Script
```bash
#!/bin/bash
# scripts/monitor-system.sh

# Check disk space
DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ $DISK_USAGE -gt 90 ]; then
    echo "WARNING: Disk usage is ${DISK_USAGE}%"
fi

# Check memory usage
MEM_USAGE=$(free | grep Mem | awk '{printf("%.0f", $3/$2 * 100.0)}')
if [ $MEM_USAGE -gt 90 ]; then
    echo "WARNING: Memory usage is ${MEM_USAGE}%"
fi

# Check for failed services
FAILED_SERVICES=$(systemctl --failed --no-legend | wc -l)
if [ $FAILED_SERVICES -gt 0 ]; then
    echo "WARNING: $FAILED_SERVICES failed services"
fi
```

#### Cron Jobs
```bash
# Add to crontab
crontab -e

# Daily system check
0 8 * * * ~/novanix/scripts/monitor-system.sh

# Weekly backup
0 2 * * 0 ~/novanix/scripts/backup-config.sh

# Monthly cleanup
0 3 1 * * sudo nix-collect-garbage -d
```

## Maintenance Checklist

### Daily
- [ ] Check system status
- [ ] Monitor logs for errors
- [ ] Check disk space
- [ ] Verify critical services

### Weekly
- [ ] Update flake inputs
- [ ] Clean up old generations
- [ ] Check for package updates
- [ ] Review system performance

### Monthly
- [ ] Full system backup
- [ ] Configuration review
- [ ] Performance optimization
- [ ] Security updates

### Quarterly
- [ ] Major system updates
- [ ] Hardware maintenance
- [ ] Configuration audit
- [ ] Documentation review

## Best Practices

### Configuration Management
1. **Version Control**: Always use git for configuration tracking
2. **Incremental Changes**: Make small, testable changes
3. **Documentation**: Document all customizations
4. **Backup**: Regular backups before major changes

### System Maintenance
1. **Regular Updates**: Keep system and packages updated
2. **Monitoring**: Monitor system health regularly
3. **Cleanup**: Regular cleanup of old files and generations
4. **Testing**: Test changes in safe environment

### Performance
1. **Optimization**: Regular performance tuning
2. **Monitoring**: Monitor resource usage
3. **Cleanup**: Remove unused packages and files
4. **Updates**: Keep drivers and firmware updated

This maintenance guide ensures your Novanix system remains healthy, secure, and performant over time. 